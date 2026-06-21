import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/theme.dart';
import '../config/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ─── App Bar ────────────────────────────────────────
      appBar: AppBar(
        title: const Text('प्रोफाइल'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),

      // ─── Body ──────────────────────────────────────────
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ─── Avatar & Name ─────────────────────────────
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'र',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'रवि कुमार',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'कक्षा 10 • CBSE',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: const Text('संपादित करें'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── Stats Grid ────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _StatCard(
                    icon: '📸',
                    label: 'सवाल',
                    value: '142',
                    color: AppTheme.primary,
                    flex: 1,
                  ),
                  const SizedBox(width: 10),
                  _StatCard(
                    icon: '🔥',
                    label: 'स्ट्रीक',
                    value: '7 दिन',
                    color: AppTheme.secondary,
                    flex: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _StatCard(
                    icon: '⭐',
                    label: 'बुकमार्क',
                    value: '24',
                    color: const Color(0xFF6A1B9A),
                    flex: 1,
                  ),
                  const SizedBox(width: 10),
                  _StatCard(
                    icon: '📚',
                    label: 'विषय',
                    value: '6',
                    color: const Color(0xFF00838F),
                    flex: 1,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ─── Subscription Card ─────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6F00), Color(0xFFFFB74D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.secondary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'फ्री प्लान',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'रोजाना 5 मुफ्त सवाल • ₹99/महीना',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'अपग्रेड करें',
                        style: TextStyle(
                          color: AppTheme.secondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ─── Menu Items ────────────────────────────────
            _menuListSection(context),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _menuListSection(BuildContext context) {
    final menuItems = [
      {'icon': Icons.history, 'label': 'हिस्ट्री', 'route': AppRoutes.history, 'color': AppTheme.primary},
      {'icon': Icons.bookmark_outline, 'label': 'बुकमार्क', 'route': AppRoutes.bookmarks, 'color': const Color(0xFF6A1B9A)},
      {'icon': Icons.emoji_events_outlined, 'label': 'उपलब्धियां', 'route': AppRoutes.achievements, 'color': AppTheme.secondary},
      {'icon': Icons.quiz_outlined, 'label': 'प्रैक्टिस', 'route': AppRoutes.practice, 'color': const Color(0xFF2E7D32)},
      {'icon': Icons.share_outlined, 'label': 'शेयर करें', 'route': null, 'color': const Color(0xFF00838F)},
      {'icon': Icons.star_outline, 'label': 'रेट करें', 'route': null, 'color': const Color(0xFFE65100)},
    ];

    return Column(
      children: menuItems.map((item) {
        return ListTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (item['color'] as Color).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
          ),
          title: Text(
            item['label'] as String,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: AppTheme.textHint),
          onTap: () {
            if (item['route'] != null) {
              context.push(item['route'] as String);
            }
          },
        );
      }).toList(),
    );
  }
}

// ─── Stat Card Widget ─────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;
  final int flex;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppTheme.cardShadow,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(icon, style: const TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textHint,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
