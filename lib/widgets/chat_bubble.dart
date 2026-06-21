import 'package:flutter/material.dart';
import '../config/theme.dart';

/// 💬 पढ़ो गुरु — Chat Bubble Widget
class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final List<String>? steps;
  final List<String>? relatedTopics;
  final bool isBookmarked;
  final bool wasHelpful;
  final String? photoPath;
  final VoidCallback? onBookmark;
  final ValueChanged<bool>? onHelpful;
  final VoidCallback? onShare;
  final ValueChanged<String>? onRelatedTopicTap;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.steps,
    this.relatedTopics,
    this.isBookmarked = false,
    this.wasHelpful = false,
    this.photoPath,
    this.onBookmark,
    this.onHelpful,
    this.onShare,
    this.onRelatedTopicTap,
  });

  /// Convert Arabic to Hindi numerals
  String _hindiNumeral(int number) {
    const h = ['०', '१', '२', '३', '४', '५', '६', '७', '८', '९'];
    return number.toString().split('').map((d) => h[int.parse(d)]).join();
  }

  @override
  Widget build(BuildContext context) {
    if (isUser) return _buildUserBubble();
    return _buildAIBubble();
  }

  Widget _buildUserBubble() {
    return Padding(
      padding: const EdgeInsets.only(left: 48, right: 16, top: 8, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (photoPath != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  photoPath!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 80,
                    width: 80,
                    color: AppTheme.divider,
                    child: const Icon(
                      Icons.broken_image,
                      color: AppTheme.textHint,
                    ),
                  ),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                16,
              ).copyWith(bottomRight: Radius.zero),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: AppTheme.textPrimary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIBubble() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 48, top: 8, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'पढ़ो गुरु',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: const Border(
                left: BorderSide(color: AppTheme.primary, width: 3),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.cardShadow,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                    height: 1.7,
                  ),
                ),
                if (steps != null && steps!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.menu_book,
                              size: 16,
                              color: AppTheme.primary,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'चरण-दर-चरण समझें',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...List.generate(steps!.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _hindiNumeral(index + 1),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    steps![index],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.textPrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
                if (relatedTopics != null && relatedTopics!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: relatedTopics!
                        .map(
                          (topic) => ActionChip(
                            label: Text(
                              topic,
                              style: const TextStyle(fontSize: 11),
                            ),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () => onRelatedTopicTap?.call(topic),
                          ),
                        )
                        .toList(),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    _ActionButton(
                      icon: wasHelpful
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      label: 'उपयोगी',
                      isActive: wasHelpful,
                      onTap: () => onHelpful?.call(!wasHelpful),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      label: 'सेव करें',
                      isActive: isBookmarked,
                      onTap: onBookmark,
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: Icons.share_outlined,
                      label: 'शेयर',
                      isActive: false,
                      onTap: onShare,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withValues(alpha: 0.1)
              : AppTheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isActive ? AppTheme.primary : AppTheme.textHint,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? AppTheme.primary : AppTheme.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
