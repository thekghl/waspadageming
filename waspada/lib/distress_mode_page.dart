import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:torch_light/torch_light.dart';

class DistressModePage extends StatefulWidget {
  @override
  State<DistressModePage> createState() => _DistressModePageState();
}

class _DistressModePageState extends State<DistressModePage> {
  double _dragPosition = 0;
  bool _isSosActive = false;
  bool _isSosRunning = false; // To track if the loop is currently executing

  @override
  void dispose() {
    _isSosActive = false;
    _disableTorchSafe();
    super.dispose();
  }

  Future<void> _disableTorchSafe() async {
    try {
      await TorchLight.disableTorch();
    } catch (_) {
      // Ignore if it fails during dispose
    }
  }

  Future<void> _runSosSequence() async {
    if (_isSosRunning) return;
    _isSosRunning = true;

    try {
      // Check availability before starting loop
      final isAvailable = await TorchLight.isTorchAvailable();
      if (!isAvailable) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Senter tidak didukung di perangkat ini.'),
              backgroundColor: Colors.redAccent,
            ),
          );
          setState(() {
            _isSosActive = false;
          });
        }
        _isSosRunning = false;
        return;
      }

      while (_isSosActive && mounted) {
        // S (3 short)
        for (int i = 0; i < 3; i++) {
          if (!_isSosActive || !mounted) break;
          await TorchLight.enableTorch();
          await Future.delayed(const Duration(milliseconds: 200));
          await TorchLight.disableTorch();
          await Future.delayed(const Duration(milliseconds: 200));
        }

        if (!_isSosActive || !mounted) break;
        await Future.delayed(
          const Duration(milliseconds: 400),
        ); // 600ms total gap between letters

        // O (3 long)
        for (int i = 0; i < 3; i++) {
          if (!_isSosActive || !mounted) break;
          await TorchLight.enableTorch();
          await Future.delayed(const Duration(milliseconds: 600));
          await TorchLight.disableTorch();
          await Future.delayed(const Duration(milliseconds: 200));
        }

        if (!_isSosActive || !mounted) break;
        await Future.delayed(
          const Duration(milliseconds: 400),
        ); // 600ms total gap between letters

        // S (3 short)
        for (int i = 0; i < 3; i++) {
          if (!_isSosActive || !mounted) break;
          await TorchLight.enableTorch();
          await Future.delayed(const Duration(milliseconds: 200));
          await TorchLight.disableTorch();
          await Future.delayed(const Duration(milliseconds: 200));
        }

        if (!_isSosActive || !mounted) break;
        await Future.delayed(
          const Duration(milliseconds: 1200),
        ); // 1400ms total gap between words
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menggunakan senter: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
        setState(() {
          _isSosActive = false;
        });
      }
    } finally {
      // Ensure torch is off when loop exits
      await _disableTorchSafe();
      _isSosRunning = false;
    }
  }

  void _toggleSosLight() {
    setState(() {
      _isSosActive = !_isSosActive;
    });
    if (_isSosActive) {
      _runSosSequence();
    }
  }

  Future<void> _launchEmergencyContact() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '112');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Panggilan tidak didukung di perangkat ini.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    const Color distressRed = Color(0xFFC62828); // Standard dark red

    return Scaffold(
      backgroundColor: distressRed,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              children: [
                // Top Triangle & Event Info
                Column(
                  children: [
                    const SizedBox(height: 20),
                    // Triangle with text
                    SizedBox(
                      width: 180,
                      height: 160,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(180, 160),
                            painter: _TrianglePainter(),
                          ),
                          const Positioned(
                            bottom: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '9.8',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'SR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Location
                    const Text(
                      'Near North Coast of West Papua',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '2,95 LS-139,64 BT',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 24),

                    // Status Badge & Time
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC8E6C9), // Light green
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Terkonfirmasi',
                              style: TextStyle(
                                color: Color(0xFF2E7D32), // Dark green
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '20 Feb 2026, 04:57:37 WIB',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Advisory Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Tidak ada lagi yang bisa dilakukan, berpasrahlah dan berdoa',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Action Buttons & Slider
                Column(
                  children: [
                    // SOS light button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _toggleSosLight,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSosActive
                              ? distressRed
                              : Colors.white,
                          side: _isSosActive
                              ? const BorderSide(color: Colors.white, width: 2)
                              : BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _isSosActive ? 'Stop SOS' : 'SOS light',
                          style: TextStyle(
                            color: _isSosActive ? Colors.white : distressRed,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Emergency Contact button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _launchEmergencyContact,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Emergency SOS',
                          style: TextStyle(
                            color: distressRed,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Slide to turn off
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          const Center(
                            child: Text(
                              'Slide to turn off',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Draggable Red Button
                          Positioned(
                            left: _dragPosition,
                            child: GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  _dragPosition += details.primaryDelta!;
                                  if (_dragPosition < 0) _dragPosition = 0;
                                  // the total width is the screen width minus padding
                                  // subtracting the button height/width (70)
                                  final double maxSlide =
                                      MediaQuery.of(context).size.width -
                                      48 -
                                      70;
                                  if (_dragPosition > maxSlide) {
                                    _dragPosition = maxSlide;
                                    Navigator.pop(
                                      context,
                                    ); // Exit distress mode
                                  }
                                });
                              },
                              onHorizontalDragEnd: (details) {
                                final double maxSlide =
                                    MediaQuery.of(context).size.width - 48 - 70;
                                if (_dragPosition < maxSlide) {
                                  setState(() {
                                    _dragPosition =
                                        0; // Snap back if not fully slid
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: const BoxDecoration(
                                    color: distressRed,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.alarm_off,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
