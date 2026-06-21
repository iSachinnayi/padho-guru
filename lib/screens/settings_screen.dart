import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _streakReminders = true;
  bool _darkMode = false;
  String _selectedLanguage = 'हिंदी';
  String _selectedClass = 'Class 10';
  String _selectedBoard = 'CBSE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('सेटिंग्स')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // ─── Account Section ────────────────────────────
          _SectionHeader(title: 'खाता'),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.person_outline,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
            title: const Text('प्रोफाइल', style: TextStyle(fontSize: 15)),
            subtitle: const Text(
              'नाम, कक्षा, बोर्ड',
              style: TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppTheme.textHint),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.workspace_premium,
                color: AppTheme.secondary,
                size: 20,
              ),
            ),
            title: const Text('सब्सक्रिप्शन', style: TextStyle(fontSize: 15)),
            subtitle: const Text(
              'फ्री प्लान • ₹99/महीना',
              style: TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppTheme.textHint),
            onTap: () {},
          ),

          const SizedBox(height: 8),
          // ─── Study Section ──────────────────────────────
          _SectionHeader(title: 'पढ़ाई'),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF6A1B9A).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.school_outlined,
                color: Color(0xFF6A1B9A),
                size: 20,
              ),
            ),
            title: const Text('कक्षा', style: TextStyle(fontSize: 15)),
            trailing: DropdownButton<String>(
              value: _selectedClass,
              underline: const SizedBox(),
              items: AppConstants.ncertClasses
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedClass = v!),
            ),
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF00838F).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.map_outlined,
                color: Color(0xFF00838F),
                size: 20,
              ),
            ),
            title: const Text('बोर्ड', style: TextStyle(fontSize: 15)),
            trailing: DropdownButton<String>(
              value: _selectedBoard,
              underline: const SizedBox(),
              items: AppConstants.boards
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBoard = v!),
            ),
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.language,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
            title: const Text('भाषा', style: TextStyle(fontSize: 15)),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              underline: const SizedBox(),
              items: [
                'हिंदी',
                'English',
              ].map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
              onChanged: (v) => setState(() => _selectedLanguage = v!),
            ),
          ),

          const SizedBox(height: 8),
          // ─── Notifications Section ──────────────────────
          _SectionHeader(title: 'सूचनाएं'),
          SwitchListTile(
            secondary: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
            title: const Text('सूचनाएं', style: TextStyle(fontSize: 15)),
            subtitle: const Text(
              'प्रमोशनल नोटिफिकेशन',
              style: TextStyle(fontSize: 12),
            ),
            value: _notificationsEnabled,
            onChanged: (v) => setState(() => _notificationsEnabled = v),
          ),
          const Divider(height: 1, indent: 72),
          SwitchListTile(
            secondary: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.local_fire_department,
                color: AppTheme.secondary,
                size: 20,
              ),
            ),
            title: const Text(
              'स्ट्रीक रिमाइंडर',
              style: TextStyle(fontSize: 15),
            ),
            subtitle: const Text(
              'रोजाना पढ़ाई की याद दिलाएं',
              style: TextStyle(fontSize: 12),
            ),
            value: _streakReminders,
            onChanged: (v) => setState(() => _streakReminders = v),
          ),

          const SizedBox(height: 8),
          // ─── Appearance Section ─────────────────────────
          _SectionHeader(title: 'दिखावट'),
          SwitchListTile(
            secondary: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.dark_mode,
                color: Color(0xFF2E7D32),
                size: 20,
              ),
            ),
            title: const Text('डार्क मोड', style: TextStyle(fontSize: 15)),
            subtitle: const Text(
              'सिस्टम सेटिंग्स को ओवरराइड करें',
              style: TextStyle(fontSize: 12),
            ),
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),

          const SizedBox(height: 8),
          // ─── About Section ──────────────────────────────
          _SectionHeader(title: 'जानकारी'),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.textHint.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.info_outline,
                color: AppTheme.textHint,
                size: 20,
              ),
            ),
            title: const Text('ऐप वर्जन', style: TextStyle(fontSize: 15)),
            trailing: const Text(
              '1.0.0',
              style: TextStyle(color: AppTheme.textHint),
            ),
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.textHint.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: AppTheme.textHint,
                size: 20,
              ),
            ),
            title: const Text('गोपनीयता नीति', style: TextStyle(fontSize: 15)),
            trailing: const Icon(Icons.chevron_right, color: AppTheme.textHint),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.textHint.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.article_outlined,
                color: AppTheme.textHint,
                size: 20,
              ),
            ),
            title: const Text('नियम व शर्तें', style: TextStyle(fontSize: 15)),
            trailing: const Icon(Icons.chevron_right, color: AppTheme.textHint),
            onTap: () {},
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}
