import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/location_result.dart';

class RecentSearchesService {
  static const String _key = 'recent_searches';

  static Future<List<LocationResult>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_key);

    if (jsonList == null || jsonList.isEmpty) {
      return [];
    }

    try {
      return jsonList.map((jsonStr) {
        final Map<String, dynamic> data = json.decode(jsonStr);
        return LocationResult.fromJson(data);
      }).toList();
    } catch (e) {
      // If data is corrupted somehow, clear it and return empty
      return [];
    }
  }

  static Future<void> addRecentSearch(LocationResult result) async {
    final prefs = await SharedPreferences.getInstance();

    // Load existing items
    List<LocationResult> recentSearches = await getRecentSearches();

    // Remove any existing identical item (by name or coordinates)
    recentSearches.removeWhere(
      (item) =>
          item.name == result.name ||
          (item.latitude == result.latitude &&
              item.longitude == result.longitude),
    );

    // Insert new item at the top
    recentSearches.insert(0, result);

    // Keep only the top 5 recent searches
    if (recentSearches.length > 5) {
      recentSearches = recentSearches.sublist(0, 5);
    }

    // Save back to SharedPreferences
    final List<String> jsonStringList = recentSearches
        .map((item) => json.encode(item.toJson()))
        .toList();

    await prefs.setStringList(_key, jsonStringList);
  }

  static Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
