class Earthquake {
  final String id;
  final String place;
  final DateTime time;
  final double magnitude;
  final double depth;
  final double latitude;
  final double longitude;

  Earthquake({
    required this.id,
    required this.place,
    required this.time,
    required this.magnitude,
    required this.depth,
    required this.latitude,
    required this.longitude,
  });

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    // Common earthquake API patterns (GeoJSON or flat JSON)
    final properties = json['properties'] ?? json;
    final geometry = json['geometry'] ?? {};
    final coordinates = geometry['coordinates'] as List? ?? [];

    return Earthquake(
      id:
          json['id']?.toString() ??
          properties['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      place:
          properties['place']?.toString() ??
          properties['location']?.toString() ??
          'Unknown Location',
      time: _parseTime(properties['time'] ?? properties['datetime']),
      magnitude:
          double.tryParse(
            properties['mag']?.toString() ??
                properties['magnitude']?.toString() ??
                '0',
          ) ??
          0.0,
      depth: coordinates.length > 2
          ? (coordinates[2] as num).toDouble()
          : (double.tryParse(properties['depth']?.toString() ?? '0') ?? 0.0),
      latitude: coordinates.length > 1
          ? (coordinates[1] as num).toDouble()
          : (double.tryParse(
                  properties['lat']?.toString() ??
                      properties['latitude']?.toString() ??
                      '0',
                ) ??
                0.0),
      longitude: coordinates.length > 0
          ? (coordinates[0] as num).toDouble()
          : (double.tryParse(
                  properties['lng']?.toString() ??
                      properties['lon']?.toString() ??
                      properties['longitude']?.toString() ??
                      '0',
                ) ??
                0.0),
    );
  }

  factory Earthquake.fromDb(Map<String, dynamic> row) {
    return Earthquake(
      id: row['id']?.toString() ?? '',
      place: row['place']?.toString() ?? 'Unknown Location',
      time: _parseTime(row['time'] ?? row['datetime']),
      magnitude: (row['magnitude'] as num?)?.toDouble() ?? 0.0,
      depth: (row['depth'] as num?)?.toDouble() ?? 0.0,
      latitude: (row['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (row['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static DateTime _parseTime(dynamic time) {
    if (time == null) return DateTime.now();
    if (time is int) return DateTime.fromMillisecondsSinceEpoch(time);
    if (time is String) {
      return DateTime.tryParse(time) ?? DateTime.now();
    }
    return DateTime.now();
  }
}
