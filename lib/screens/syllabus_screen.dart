import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/syllabus_provider.dart';
import '../models/subject_model.dart';

/// 📚 पढ़ो गुरु — Syllabus Screen
class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final syllabus = context.watch<SyllabusProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('पाठ्यक्रम ${_getClassLabel(syllabus.selectedClass)}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context, syllabus),
          ),
        ],
      ),
      body: Column(
        children: [
          // ─── Class Selector ──────────────────────────────
          _buildClassSelector(syllabus),
          // ─── Subject Tabs ────────────────────────────────
          _buildSubjectTabs(syllabus),
          // ─── Chapter List ────────────────────────────────
          Expanded(
            child: syllabus.isLoading
                ? const Center(child: CircularProgressIndicator())
                : syllabus.selectedSubject != null
                    ? _buildChapterList(syllabus)
                    : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  // ─── Class Selector ───────────────────────────────────────
  Widget _buildClassSelector(SyllabusProvider syllabus) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.school_outlined, size: 18, color: AppTheme.textHint),
          const SizedBox(width: 8),
          const Text('कक्षा:', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: syllabus.classes.map((cls) {
                  final isSelected = cls == syllabus.selectedClass;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => syllabus.selectClass(cls),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primary : AppTheme.background,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cls.replaceAll('Class ', ''),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? Colors.white : AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Subject Tabs ─────────────────────────────────────────
  Widget _buildSubjectTabs(SyllabusProvider syllabus) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: syllabus.subjects.length,
        itemBuilder: (context, index) {
          final subject = syllabus.subjects[index];
          final isSelected = subject.id == syllabus.selectedSubject?.id;
          return GestureDetector(
            onTap: () => syllabus.selectSubject(subject),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary.withValues(alpha: 0.1) : null,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? const Border(
                        bottom: BorderSide(color: AppTheme.primary, width: 2))
                    : null,
              ),
              child: Row(
                children: [
                  Text(subject.icon, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(
                    subject.nameHindi,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── Chapter List ─────────────────────────────────────────
  Widget _buildChapterList(SyllabusProvider syllabus) {
    final subject = syllabus.selectedSubject!;
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: subject.chapters.length + 1, // +1 for header
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildSubjectHeader(subject);
          }
          final chapter = subject.chapters[index - 1];
          return _buildChapterTile(chapter, syllabus);
        },
      ),
    );
  }

  Widget _buildSubjectHeader(SubjectModel subject) {
    final completed = subject.chapters.where((c) => c.isDownloaded).length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          Text(
            '${subject.chapters.length} अध्याय',
            style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
          const Spacer(),
          Text(
            '$completed/${subject.chapters.length} डाउनलोड',
            style: const TextStyle(fontSize: 12, color: AppTheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterTile(ChapterModel chapter, SyllabusProvider syllabus) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: chapter.isDownloaded
                  ? AppTheme.success.withValues(alpha: 0.1)
                  : AppTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                chapter.chapterNumber,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: chapter.isDownloaded ? AppTheme.success : AppTheme.primary,
                ),
              ),
            ),
          ),
          title: Text(
            chapter.titleHindi,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                '${chapter.questionCount} सवाल',
                style: const TextStyle(fontSize: 11, color: AppTheme.textHint),
              ),
              const SizedBox(width: 8),
              if (chapter.isDownloaded)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'डाउनलोड',
                    style: TextStyle(fontSize: 10, color: AppTheme.success),
                  ),
                ),
            ],
          ),
          trailing: GestureDetector(
            onTap: () => syllabus.toggleDownload(chapter.id),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: chapter.isDownloaded
                    ? AppTheme.success.withValues(alpha: 0.1)
                    : AppTheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                chapter.isDownloaded ? Icons.download_done : Icons.download_outlined,
                size: 18,
                color: chapter.isDownloaded ? AppTheme.success : AppTheme.textHint,
              ),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'इस अध्याय में:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...chapter.topics.map((topic) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(color: AppTheme.primary)),
                            Expanded(
                              child: Text(
                                topic,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  if (chapter.topics.isEmpty)
                    const Text(
                      'विषय सूची जल्द आ रही है',
                      style: TextStyle(fontSize: 12, color: AppTheme.textHint),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => syllabus.toggleDownload(chapter.id),
                      icon: Icon(
                        chapter.isDownloaded ? Icons.check : Icons.download_outlined,
                        size: 16,
                      ),
                      label: Text(
                        chapter.isDownloaded ? 'डाउनलोड हो गया' : 'ऑफलाइन पढ़ें',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_outlined, size: 64, color: AppTheme.textHint),
          SizedBox(height: 12),
          Text(
            'कोई विषय चुनें',
            style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  // ─── Search Dialog ────────────────────────────────────────
  void _showSearch(BuildContext context, SyllabusProvider syllabus) {
    showSearch(
      context: context,
      delegate: _SyllabusSearchDelegate(syllabus),
    );
  }

  String _getClassLabel(String cls) {
    return cls.replaceAll('Class ', '');
  }
}

// ─── Search Delegate ─────────────────────────────────────────
class _SyllabusSearchDelegate extends SearchDelegate<String?> {
  final SyllabusProvider syllabus;

  _SyllabusSearchDelegate(this.syllabus);

  @override
  String get searchFieldLabel => 'अध्याय खोजें...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white60),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    syllabus.search(query);
    final results = syllabus.searchResults;

    if (results.isEmpty) {
      return const Center(
        child: Text('कोई परिणाम नहीं मिला',
            style: TextStyle(color: AppTheme.textSecondary)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final chapter = results[index];
        return ListTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                chapter.chapterNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          title: Text(chapter.titleHindi),
          subtitle: Text('${chapter.questionCount} सवाल'),
          trailing: Icon(
            chapter.isDownloaded ? Icons.download_done : Icons.download_outlined,
            color: chapter.isDownloaded ? AppTheme.success : AppTheme.textHint,
            size: 20,
          ),
          onTap: () => close(context, chapter.id),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('अध्याय का नाम टाइप करें',
            style: TextStyle(color: AppTheme.textSecondary)),
      );
    }
    syllabus.search(query);
    return buildResults(context);
  }
}
