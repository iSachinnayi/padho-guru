import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 🎊 पढ़ो गुरु — Confetti Widget for Achievements
class ConfettiWidget extends StatefulWidget {
  final bool show;
  final Widget child;

  const ConfettiWidget({super.key, required this.show, required this.child});

  @override
  State<ConfettiWidget> createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.show) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ConfettiWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.show)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _ConfettiPainter(progress: _controller.value),
              );
            },
          ),
      ],
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final double progress;

  _ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint();

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height * 0.5;
      final y = startY + (progress * size.height * 0.6);
      final rotation = (progress * 4 * math.pi) + (i * 0.5);
      final opacity = (1 - progress).clamp(0.0, 1.0);

      paint.color = [
        const Color(0xFF1565C0),
        const Color(0xFFFF6F00),
        const Color(0xFF2E7D32),
        const Color(0xFFC62828),
        const Color(0xFF6A1B9A),
      ][i % 5].withValues(alpha: opacity);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);

      final w = 6.0 * (1 - progress * 0.5);
      final h = 12.0 * (1 - progress * 0.5);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(-w / 2, -h / 2, w, h),
          const Radius.circular(2),
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
