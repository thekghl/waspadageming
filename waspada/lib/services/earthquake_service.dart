import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/earthquake.dart';
import '../main.dart';

class EarthquakeService {
  static Future<List<Earthquake>> fetchEarthquakes(String date) async {
    try {
      final Uri uri = Uri.parse('${ApiConfig.baseUrl}/earthquakes?date=$date');
      debugPrint('Fetching earthquakes from: $uri');

      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final dynamic decoded = json.decode(response.body);
        List<dynamic> data;

        if (decoded is List) {
          data = decoded;
        } else if (decoded is Map) {
          data =
              decoded['data'] ??
              decoded['earthquakes'] ??
              decoded['features'] ??
              [];
        } else {
          data = [];
        }

        return data.map((item) => Earthquake.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to fetch earthquakes: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
