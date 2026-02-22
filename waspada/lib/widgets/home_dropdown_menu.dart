import 'package:flutter/material.dart';
import 'package:waspada/distress_mode_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDropdownMenu extends StatelessWidget {
  const HomeDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80, // Adjust based on SafeArea and AppBar height
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.shield,
                label: 'Safety Guide',
                onTap: () {}, // Not implemented in this static UI scope
              ),
              const Divider(height: 1, thickness: 1),
              _buildMenuItem(
                context,
                icon: Icons.contact_emergency,
                label: 'Emergency SOS',
                onTap: () async {
                  Navigator.pop(context); // Close the menu

                  final Uri phoneUri = Uri(scheme: 'tel', path: '112');
                  try {
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Panggilan tidak didukung di perangkat ini.',
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Gagal: Pastikan aplikasi sudah di-restart secara penuh (Restart, bukan Hot Reload). Error: $e',
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  }
                },
              ),
              const Divider(height: 1, thickness: 1),
              _buildMenuItem(
                context,
                icon: Icons.warning,
                label: 'Distress Mode',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(context); // Close the menu before navigating
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DistressModePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isDestructive ? FontWeight.bold : FontWeight.normal,
                color: isDestructive ? Colors.red : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper to show the custom positioned dropdown
void showHomeDropdown(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          // Barrier to detect taps outside
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),
          const HomeDropdownMenu(),
        ],
      );
    },
  );
}
