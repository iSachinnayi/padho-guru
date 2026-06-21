import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../config/routes.dart';
import '../widgets/camera_overlay.dart';
import '../widgets/haptic_util.dart';

/// 📸 पढ़ो गुरु — Camera Screen
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _capturedImage;
  bool _flashOn = false;
  bool _isProcessing = false;
  double _captureScale = 1.0;

  // ─── Capture Photo ───────────────────────────────────────
  Future<void> _capturePhoto() async {
    try {
      final photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        imageQuality: 70,
      );
      if (photo != null && mounted) {
        setState(() => _capturedImage = photo);
      }
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
      // Fallback to gallery if camera fails
      await _pickFromGallery();
    }
  }

  Future<void> _pickFromGallery() async {
    final photo = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 70,
    );
    if (photo != null && mounted) {
      setState(() => _capturedImage = photo);
    }
  }

  // ─── Submit Question ─────────────────────────────────────
  Future<void> _submitQuestion() async {
    if (_capturedImage == null) return;

    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      context.push(AppRoutes.chat, extra: {'photoPath': _capturedImage!.path});
      setState(() => _isProcessing = false);
    }
  }

  // ─── Retake ──────────────────────────────────────────────
  void _retake() {
    setState(() {
      _capturedImage = null;
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _capturedImage == null
            ? _buildCameraPreview()
            : _buildReviewScreen(),
      ),
    );
  }

  // ─── Camera Preview ──────────────────────────────────────
  Widget _buildCameraPreview() {
    return Stack(
      children: [
        // Camera preview placeholder (gradient background)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // Camera grid pattern overlay
        CustomPaint(size: Size.infinite, painter: _GridPainter()),

        // Camera guide overlay
        CameraOverlay(previewHeight: MediaQuery.of(context).size.height),

        // ─── Top Controls ──────────────────────────────────
        Positioned(
          top: 8,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close button
                _TopIconButton(icon: Icons.close, onTap: () => context.pop()),
                // Header text
                const Text(
                  'फोटो खींचो',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Torch toggle
                _TopIconButton(
                  icon: _flashOn ? Icons.flash_on : Icons.flash_off,
                  onTap: () => setState(() => _flashOn = !_flashOn),
                ),
              ],
            ),
          ),
        ),

        // ─── Bottom Controls ───────────────────────────────
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gallery
              GestureDetector(
                onTap: _pickFromGallery,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _capturedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_capturedImage!.path),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.photo_library_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.photo_library_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                ),
              ),
              const SizedBox(width: 30),
              // Capture button
              GestureDetector(
                onTap: () {
                  HapticUtil.mediumTap();
                  setState(() => _captureScale = 0.9);
                  Future.delayed(const Duration(milliseconds: 150), () {
                    if (mounted) setState(() => _captureScale = 1.0);
                  });
                  _capturePhoto();
                },
                child: AnimatedScale(
                  scale: _captureScale,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.elasticOut,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              // Flash toggle
              GestureDetector(
                onTap: () => setState(() => _flashOn = !_flashOn),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _flashOn ? Icons.flash_on : Icons.flash_off,
                    color: _flashOn ? Colors.yellow : Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Review Screen ───────────────────────────────────────
  Widget _buildReviewScreen() {
    return Column(
      children: [
        // Top bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _retake,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  'पुनः लें',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('क्रॉप सुविधा जल्द आ रही है'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text(
                  'क्रॉप करें',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        // Image preview
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(_capturedImage!.path),
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Bottom actions
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _isProcessing ? null : _submitQuestion,
              icon: _isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(
                _isProcessing ? 'समझ रहे हैं...' : 'सवाल पूछें',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Top Icon Button ───────────────────────────────────────
class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

// ─── Grid Pattern Painter ──────────────────────────────────
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 0.5;

    // Vertical lines
    for (double x = 0; x < size.width; x += size.width / 3) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    // Horizontal lines
    for (double y = 0; y < size.height; y += size.height / 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
