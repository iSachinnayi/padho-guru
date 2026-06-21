/// पढ़ो गुरु — Subject & Chapter Models
class SubjectModel {
  final String id;
  final String name;
  final String nameHindi;
  final String icon;
  final int totalChapters;
  final int completedChapters;
  final List<ChapterModel> chapters;

  SubjectModel({
    required this.id,
    required this.name,
    required this.nameHindi,
    this.icon = '📖',
    this.totalChapters = 0,
    this.completedChapters = 0,
    List<ChapterModel>? chapters,
  }) : chapters = chapters ?? [];

  double get progress =>
      totalChapters > 0 ? completedChapters / totalChapters : 0;
}

class ChapterModel {
  final String id;
  final String title;
  final String titleHindi;
  final String chapterNumber;
  final int questionCount;
  final bool isDownloaded;
  final List<String> topics;
  final double progress;

  ChapterModel({
    required this.id,
    required this.title,
    required this.titleHindi,
    required this.chapterNumber,
    this.questionCount = 0,
    this.isDownloaded = false,
    List<String>? topics,
    this.progress = 0,
  }) : topics = topics ?? [];
}
