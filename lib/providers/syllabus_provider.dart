import 'package:flutter/foundation.dart';
import '../models/subject_model.dart';
import '../services/syllabus_service.dart';

/// पढ़ो गुरु — Syllabus State Provider
class SyllabusProvider extends ChangeNotifier {
  final SyllabusService _syllabusService = SyllabusService();

  // ─── State ────────────────────────────────────────────────
  String _selectedClass = 'Class 10';
  SubjectModel? _selectedSubject;
  List<SubjectModel> _subjects = [];
  bool _isLoading = false;
  String _searchQuery = '';
  List<ChapterModel> _searchResults = [];

  // ─── Getters ──────────────────────────────────────────────
  String get selectedClass => _selectedClass;
  SubjectModel? get selectedSubject => _selectedSubject;
  List<SubjectModel> get subjects => _subjects;
  List<String> get classes => _syllabusService.classes;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  List<ChapterModel> get searchResults => _searchResults;

  // ─── Initialize ───────────────────────────────────────────
  SyllabusProvider() {
    _loadSubjects();
  }

  void _loadSubjects() {
    _isLoading = true;
    notifyListeners();

    _subjects = _syllabusService.getSubjects(_selectedClass);
    if (_subjects.isNotEmpty && _selectedSubject == null) {
      _selectedSubject = _subjects.first;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ─── Select Class ─────────────────────────────────────────
  void selectClass(String className) {
    if (_selectedClass == className) return;
    _selectedClass = className;
    _searchQuery = '';
    _searchResults = [];
    _loadSubjects();
  }

  // ─── Select Subject ──────────────────────────────────────
  void selectSubject(SubjectModel subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  // ─── Search ───────────────────────────────────────────────
  void search(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _syllabusService.search(query, _selectedClass);
    }
    notifyListeners();
  }

  // ─── Toggle Download ──────────────────────────────────────
  Future<void> toggleDownload(String chapterId) async {
    // TODO: Actual offline download via sqflite
    await Future.delayed(const Duration(milliseconds: 300));

    for (final subject in _subjects) {
      for (int i = 0; i < subject.chapters.length; i++) {
        if (subject.chapters[i].id == chapterId) {
          final updated = ChapterModel(
            id: subject.chapters[i].id,
            title: subject.chapters[i].title,
            titleHindi: subject.chapters[i].titleHindi,
            chapterNumber: subject.chapters[i].chapterNumber,
            questionCount: subject.chapters[i].questionCount,
            isDownloaded: !subject.chapters[i].isDownloaded,
            topics: subject.chapters[i].topics,
            progress: subject.chapters[i].progress,
          );
          subject.chapters[i] = updated;
          notifyListeners();
          return;
        }
      }
    }
  }
}
