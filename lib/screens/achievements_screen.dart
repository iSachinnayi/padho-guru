import 'package:flutter/material.dart';
import '../config/theme.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final List<Map<String, dynamic>> _badges = [
    {'icon': '🔥', 'title': '7 दिन की स्ट्रीक', 'desc': 'लगातार 7 दिन सवाल पूछे', 'progress': 1.0, 'color': const Color(0xFFFF6F00)},
    {'icon': '📸', 'title': 'फोटो मास्टर', 'desc': '50 फोटो खींचे', 'progress': 0.64, 'color': AppTheme.primary},
    {'icon': '💡', 'title': '100 सवाल', 'desc': '100 सवाल पूछे', 'progress': 0.42, 'color': const Color(0xFF6A1B9A)},
    {'icon': '⭐', 'title': 'टॉप रेटेड', 'desc': '10 जवाब उपयोगी मार्क हुए', 'progress': 0.5, 'color': const Color(0xFF2E7D32)},
    {'icon': '📚', 'title': 'बुकवर्म', 'desc': '5 अध्याय डाउनलोड किए', 'progress': 0.4, 'color': const Color(0xFF00838F)},
    {'icon': '🎯', 'title': 'प्रैक्टिस चैंप', 'desc': '10 प्रैक्टिस टेस्ट दिए', 'progress': 0.0, 'color': const Color(0xFFE65100)},
  ];

  @override
  Widget build(BuildContext context) {
    final completed = _badges.where((b) => (b['progress'] as double) >= 1.0).length;

    return Scaffold(
      appBar: AppBar(title: const Text('उपलब्धियां')),
      body: Column(
        children: [
          // Progress summary card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('🏆', style: TextStyle(fontSize: 28))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('तुम्हारी प्रगति', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: completed / _badges.length,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('$completed/${_badges.length} बैज अनलॉक', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Badges grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.1,
                crossAxisSpacing: 10, mainAxisSpacing: 10,
              ),
              itemCount: _badges.length,
              itemBuilder: (context, index) {
                final badge = _badges[index];
                final isComplete = (badge['progress'] as double) >= 1.0;
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 4, offset: const Offset(0, 1))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(opacity: isComplete ? 1.0 : 0.4, child: Text(badge['icon'] as String, style: const TextStyle(fontSize: 32))),
                      const SizedBox(height: 6),
                      Text(badge['title'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isComplete ? AppTheme.textPrimary : AppTheme.textHint), textAlign: TextAlign.center),
                      const SizedBox(height: 2),
                      Text(badge['desc'] as String, style: const TextStyle(fontSize: 10, color: AppTheme.textHint), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: badge['progress'] as double,
                          backgroundColor: AppTheme.divider,
                          valueColor: AlwaysStoppedAnimation<Color>(badge['color'] as Color),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
