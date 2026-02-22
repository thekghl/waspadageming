import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location_result.dart';

class GeocodingService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org/search';

  static Future<List<LocationResult>> fetchLocations(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final Uri uri = Uri.parse(
        '$_baseUrl?q=${Uri.encodeComponent(query)}&format=jsonv2&addressdetails=1',
      );

      final response = await http
          .get(
            uri,
            headers: {
              'User-Agent': 'WaspadaApp/1.0', // Required by Nominatim policy
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => LocationResult.fromJson(json)).toList();
      } else {
        // Log or handle non-200 responses appropriately
        return [];
      }
    } catch (e) {
      // Catch SocketException (offline), TimeoutException, FormatException, etc.
      return [];
    }
  }
}
