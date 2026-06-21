/// पढ़ो गुरु — Question Model
class QuestionModel {
  final String id;
  final String text;
  final String? photoUrl;
  final String? subject;
  final String? studentClass;
  final String? board;
  final String language;
  final DateTime createdAt;

  QuestionModel({
    required this.id,
    required this.text,
    this.photoUrl,
    this.subject,
    this.studentClass,
    this.board,
    this.language = 'hi',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'photoUrl': photoUrl ?? '',
        'subject': subject ?? '',
        'class': studentClass ?? '',
        'board': board ?? '',
        'language': language,
        'createdAt': createdAt.toIso8601String(),
      };

  factory QuestionModel.fromJson(Map<String, dynamic> json, String id) {
    return QuestionModel(
      id: id,
      text: json['text'] ?? '',
      photoUrl: json['photoUrl'],
      subject: json['subject'],
      studentClass: json['class'],
      board: json['board'],
      language: json['language'] ?? 'hi',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
