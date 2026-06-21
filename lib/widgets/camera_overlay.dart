import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 📸 पढ़ो गुरु — Camera Overlay Guide Widget
class CameraOverlay extends StatelessWidget {
  final double previewHeight;

  const CameraOverlay({super.key, required this.previewHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Darkened areas
        ClipPath(
          clipper: _GuideClipper(previewHeight: previewHeight),
          child: Container(color: Colors.black.withValues(alpha: 0.5)),
        ),
        // Guide border
        Positioned(
          top: previewHeight * 0.15,
          left: 32,
          right: 32,
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        // Corner brackets
        ..._buildCornerBrackets(context),
        // Instruction text
        Positioned(
          bottom: previewHeight * 0.05,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_fix_high, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'सवाल को फ्रेम में रखें',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCornerBrackets(BuildContext context) {
    final top = previewHeight * 0.15;
    final left = 32.0;
    final right = 32.0;
    final guideWidth = MediaQuery.of(context).size.width - 64;
    final guideHeight = guideWidth * 4 / 3;

    return [
      // Top-left
      Positioned(
        top: top - 2,
        left: left - 2,
        child: _CornerBracket(rotation: 0),
      ),
      // Top-right
      Positioned(
        top: top - 2,
        right: right - 2,
        child: _CornerBracket(rotation: 90),
      ),
      // Bottom-left
      Positioned(
        top: top + guideHeight - 18,
        left: left - 2,
        child: _CornerBracket(rotation: 270),
      ),
      // Bottom-right
      Positioned(
        top: top + guideHeight - 18,
        right: right - 2,
        child: _CornerBracket(rotation: 180),
      ),
    ];
  }
}

class _CornerBracket extends StatelessWidget {
  final int rotation;

  const _CornerBracket({required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * math.pi / 180,
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white, width: 3),
            left: BorderSide(color: Colors.white, width: 3),
          ),
        ),
      ),
    );
  }
}

class _GuideClipper extends CustomClipper<Path> {
  final double previewHeight;

  _GuideClipper({required this.previewHeight});

  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final guideWidth = size.width - 64;
    final guideHeight = guideWidth * 4 / 3;
    final guideTop = previewHeight * 0.15;
    final guideLeft = 32.0;

    final guidePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(guideLeft, guideTop, guideWidth, guideHeight),
          const Radius.circular(12),
        ),
      );

    return Path.combine(PathOperation.difference, path, guidePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldDelegate) => false;
}
