import 'package:flutter/material.dart';
import '../config/theme.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final List<Map<String, dynamic>> _bookmarks = [
    {
      'question': 'प्रकाश का परावर्तन क्या है?',
      'subject': 'Science',
      'chapter': 'Chapter 10 - प्रकाश',
      'icon': '🔬',
    },
    {
      'question': 'प्रकाश संश्लेषण किसे कहते हैं?',
      'subject': 'Science',
      'chapter': 'Chapter 6 - जीवन प्रक्रियाएं',
      'icon': '🔬',
    },
    {
      'question': 'पाइथागोरस प्रमेय क्या है?',
      'subject': 'Maths',
      'chapter': 'Chapter 6 - त्रिभुज',
      'icon': '📐',
    },
    {
      'question': 'कोशिका किसे कहते हैं?',
      'subject': 'Science',
      'chapter': 'Chapter 5 - जीवन',
      'icon': '🔬',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_bookmarks.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('बुकमार्क')),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bookmark_outline, size: 64, color: AppTheme.textHint),
              SizedBox(height: 12),
              Text('कोई बुकमार्क नहीं',
                  style: TextStyle(fontSize: 16, color: AppTheme.textSecondary)),
              SizedBox(height: 4),
              Text('सवालों के जवाब सेव करें',
                  style: TextStyle(fontSize: 13, color: AppTheme.textHint)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('बुकमार्क (${_bookmarks.length})'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          final item = _bookmarks[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(14),
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
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(item['icon'], style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(
                        item['subject'],
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            size: 18, color: AppTheme.textHint),
                        onPressed: () {
                          setState(() => _bookmarks.removeAt(index));
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['question'],
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500, height: 1.4),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['chapter'],
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.textHint),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
