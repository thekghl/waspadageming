class LocationResult {
  final String name;
  final double latitude;
  final double longitude;

  LocationResult({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory LocationResult.fromJson(Map<String, dynamic> json) {
    return LocationResult(
      name:
          json['display_name'] ??
          json['name'] ??
          'Unknown Location', // handle both raw nominatim format and our saved format
      latitude: double.tryParse(json['lat']?.toString() ?? '0') ?? 0.0,
      longitude: double.tryParse(json['lon']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    };
  }
}
