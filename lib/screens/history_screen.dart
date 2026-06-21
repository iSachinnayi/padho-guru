import 'package:flutter/material.dart';
import '../config/theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _searchController = TextEditingController();
  String _filter = 'सभी';

  final _filters = ['सभी', 'आज', 'इस हफ्ते', 'इस महीने'];

  // Mock history data
  final List<Map<String, dynamic>> _history = List.generate(
    20,
    (i) => {
      'id': 'h_$i',
      'question': [
        'प्रकाश का परावर्तन क्या है?',
        'प्रकाश संश्लेषण किसे कहते हैं?',
        'बहुपद किसे कहते हैं?',
        'न्यूटन की गति का प्रथम नियम',
        'अम्ल और क्षारक में अंतर',
        'कोशिका किसे कहते हैं?',
        'पाइथागोरस प्रमेय',
        'ऊर्जा संरक्षण का नियम',
      ][i % 8],
      'subject': ['Science', 'Science', 'Maths', 'Science', 'Science', 'Science', 'Maths', 'Science'][i % 8],
      'time': '${i + 1} घंटे पहले',
      'bookmarked': i % 3 == 0,
    },
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _history.where((h) {
      final matchesSearch = _searchController.text.isEmpty ||
          (h['question'] as String)
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      return matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('हिस्ट्री')),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'पुराने सवाल खोजें...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          // Filter chips
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Row(
              children: _filters.map((f) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(f, style: const TextStyle(fontSize: 12)),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )).toList(),
            ),
          ),
          // List
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text('कोई हिस्ट्री नहीं',
                        style: TextStyle(color: AppTheme.textSecondary)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.cardShadow,
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                item['subject'] == 'Science' ? '🔬' : '📐',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          title: Text(
                            item['question'],
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${item['subject']} • ${item['time']}',
                            style: const TextStyle(
                                fontSize: 11, color: AppTheme.textHint),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              item['bookmarked']
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              size: 18,
                              color: item['bookmarked']
                                  ? AppTheme.primary
                                  : AppTheme.textHint,
                            ),
                            onPressed: () => setState(() {}),
                          ),
                          onTap: () {},
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
