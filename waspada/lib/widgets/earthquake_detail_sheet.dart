import 'package:flutter/material.dart';
import '../models/earthquake.dart';
import 'package:intl/intl.dart';

class EarthquakeDetailSheet extends StatelessWidget {
  final Earthquake? earthquake;

  const EarthquakeDetailSheet({super.key, this.earthquake});

  @override
  Widget build(BuildContext context) {
    final quake = earthquake;

    // Fallback labels if no earthquake is selected (should not happen if opened from marker)
    final place = quake?.place ?? 'Informasi Gempa';
    final coords = quake != null
        ? '${quake.latitude.toStringAsFixed(2)}, ${quake.longitude.toStringAsFixed(2)}'
        : '--';
    final mag = quake?.magnitude.toStringAsFixed(1) ?? '--';
    final depth = quake?.depth.toStringAsFixed(1) ?? '--';
    final timeStr = quake != null
        ? DateFormat('dd MMM yyyy, HH:mm:ss').format(quake.time) + ' WIB'
        : '--';

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            coords,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getMagnitudeColor(quake?.magnitude ?? 0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        mag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Terkonfirmasi',
                    style: TextStyle(
                      color: Color(0xFF388E3C),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  timeStr,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.show_chart,
                                color: Colors.red.shade400,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Magnitudo:',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Text(
                            mag,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.adjust,
                                color: Colors.green.shade400,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Kedalaman:',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Text(
                            '$depth km',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // History Table
          Container(
            color: const Color(0xFFEBEBEB), // Light gray header row
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Waktu (WIB)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Kedalaman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Magnitudo',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            child: Column(
              children: [
                _buildHistoryTableRow('21 Feb 2026 12:10:38', '58', '3.33'),
                const Divider(height: 24, color: Color(0xFFEEEEEE)),
                _buildHistoryTableRow('21 Feb 2026 12:10:38', '58', '3.33'),
                const Divider(height: 24, color: Color(0xFFEEEEEE)),
                _buildHistoryTableRow('21 Feb 2026 12:10:38', '58', '3.33'),
                const Divider(height: 24, color: Color(0xFFEEEEEE)),
                _buildHistoryTableRow('21 Feb 2026 12:10:38', '58', '3.33'),
                const SizedBox(height: 12), // Bottom padding for safety
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getMagnitudeColor(double magnitude) {
    if (magnitude >= 7.0) return Colors.purple;
    if (magnitude >= 6.0) return Colors.red;
    if (magnitude >= 5.0) return Colors.orange;
    if (magnitude >= 4.0) return Colors.yellow.shade800;
    return const Color(0xFF4CAF50); // Green
  }

  Widget _buildHistoryTableRow(
    String waktu,
    String kedalaman,
    String magnitudo,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            waktu,
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            kedalaman,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            magnitudo,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          ),
        ),
      ],
    );
  }
}
