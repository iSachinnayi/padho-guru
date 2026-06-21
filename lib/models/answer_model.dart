/// पढ़ो गुरु — Answer Model
class AnswerModel {
  final String id;
  final String questionText;
  final String answer;
  final List<String> steps;
  final List<String>? relatedTopics;
  final String? subject;
  final String? chapter;
  final String language;
  final bool isBookmarked;
  final bool wasHelpful;
  final DateTime createdAt;

  AnswerModel({
    required this.id,
    required this.questionText,
    required this.answer,
    required this.steps,
    this.relatedTopics,
    this.subject,
    this.chapter,
    this.language = 'hi',
    this.isBookmarked = false,
    this.wasHelpful = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Sample answer for preview/testing
  static AnswerModel get sample {
    return AnswerModel(
      id: 'sample_1',
      questionText: 'प्रकाश का परावर्तन क्या है?',
      answer:
          'प्रकाश का परावर्तन वह घटना है जब प्रकाश की किरण किसी चिकनी व चमकदार सतह से टकराकर वापस उसी माध्यम में लौट जाती है। यह एक महत्वपूर्ण भौतिकी घटना है जो हमारे दैनिक जीवन में बहुत उपयोगी है।\n\nजब प्रकाश किसी सतह पर गिरता है, तो उसका कुछ भाग परावर्तित हो जाता है, कुछ अवशोषित हो जाता है, और कुछ संचारित हो जाता है। परावर्तन में, प्रकाश की किरण अपने मूल माध्यम में ही वापस लौटती है।',
      steps: [
        'प्रकाश की किरण एक सीधी रेखा में चलती है - जब यह किसी चिकनी सतह (जैसे दर्पण) पर गिरती है, तो इसकी दिशा बदल जाती है।',
        'आपतित किरण (Incident Ray) - वह किरण जो सतह पर गिरती है। इसे AO द्वारा दर्शाया जाता है।',
        'परावर्तित किरण (Reflected Ray) - वह किरण जो सतह से टकराकर वापस लौटती है। इसे OB द्वारा दर्शाया जाता है।',
        'अभिलम्ब (Normal) - वह काल्पनिक रेखा जो आपतन बिंदु पर सतह के लंबवत होती है। इसे ON द्वारा दर्शाया जाता है।',
        'परावर्तन के नियम: (१) आपतित कोण = परावर्तित कोण, (२) आपतित किरण, परावर्तित किरण और अभिलम्ब एक ही तल में होते हैं।',
      ],
      relatedTopics: [
        'प्रकाश का अपवर्तन',
        'गोलीय दर्पण',
        'प्रकाश का प्रकीर्णन',
      ],
      subject: 'Science',
      chapter: 'Chapter 10 - प्रकाश',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionText': questionText,
    'answer': answer,
    'steps': steps,
    'relatedTopics': relatedTopics ?? [],
    'subject': subject ?? '',
    'chapter': chapter ?? '',
    'language': language,
    'isBookmarked': isBookmarked,
    'wasHelpful': wasHelpful,
    'createdAt': createdAt.toIso8601String(),
  };

  factory AnswerModel.fromJson(Map<String, dynamic> json, String id) {
    return AnswerModel(
      id: id,
      questionText: json['questionText'] ?? '',
      answer: json['answer'] ?? '',
      steps: List<String>.from(json['steps'] ?? []),
      relatedTopics: List<String>.from(json['relatedTopics'] ?? []),
      subject: json['subject'],
      chapter: json['chapter'],
      language: json['language'] ?? 'hi',
      isBookmarked: json['isBookmarked'] ?? false,
      wasHelpful: json['wasHelpful'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  AnswerModel copyWith({bool? isBookmarked, bool? wasHelpful}) {
    return AnswerModel(
      id: id,
      questionText: questionText,
      answer: answer,
      steps: steps,
      relatedTopics: relatedTopics,
      subject: subject,
      chapter: chapter,
      language: language,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      wasHelpful: wasHelpful ?? this.wasHelpful,
      createdAt: createdAt,
    );
  }
}
