import 'package:flutter/material.dart';
import '../config/theme.dart';

/// 📚 पढ़ो गुरु — Subject Card Widget
class SubjectCard extends StatefulWidget {
  final String name;
  final String icon;
  final String chapterCount;
  final double progress;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    this.chapterCount = '0',
    this.progress = 0,
    this.color,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final cardColor = widget.color ?? AppTheme.primary;

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        transform: _isPressed
            ? (Matrix4.diagonal3Values(1.03, 1.03, 1.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.cardShadow,
              blurRadius: _isPressed ? 12 : 8,
              offset: Offset(0, _isPressed ? 4 : 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Subject Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cardColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(widget.icon, style: const TextStyle(fontSize: 22)),
                ),
              ),
              const Spacer(),
              // Subject Name
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Chapter Count + Progress
              Row(
                children: [
                  Text(
                    '${widget.chapterCount} अध्याय',
                    style: TextStyle(fontSize: 11, color: AppTheme.textHint),
                  ),
                  const Spacer(),
                  // Mini progress
                  if (widget.progress > 0)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: cardColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
