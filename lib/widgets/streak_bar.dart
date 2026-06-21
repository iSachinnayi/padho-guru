import 'package:flutter/material.dart';
import '../config/theme.dart';

/// 🔥 पढ़ो गुरु — Streak Bar Widget
class StreakBar extends StatelessWidget {
  final int streak;
  final int questionsToday;
  final int totalQuestions;

  const StreakBar({
    super.key,
    this.streak = 0,
    this.questionsToday = 0,
    this.totalQuestions = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: streak > 0
              ? [AppTheme.secondary, AppTheme.secondaryLight]
              : [AppTheme.textHint.withValues(alpha: 0.3), AppTheme.divider],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Streak Fire Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '🔥',
                style: TextStyle(fontSize: streak > 0 ? 24 : 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Streak Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  streak > 0 ? 'लगातार $streak दिन! 🔥' : 'आज पढ़ाई शुरू करो!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: streak > 0 ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'आज $questionsToday सवाल • कुल $totalQuestions',
                  style: TextStyle(
                    fontSize: 11,
                    color: streak > 0
                        ? Colors.white.withValues(alpha: 0.8)
                        : AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Progress indicator
          SizedBox(
            width: 36,
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: questionsToday / 5,
                  strokeWidth: 3,
                  color: streak > 0 ? Colors.white : AppTheme.primary,
                  backgroundColor: streak > 0
                      ? Colors.white.withValues(alpha: 0.3)
                      : AppTheme.divider,
                ),
                Text(
                  '$questionsToday',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: streak > 0 ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
