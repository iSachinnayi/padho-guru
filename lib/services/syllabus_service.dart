import '../models/subject_model.dart';

/// पढ़ो गुरु — Syllabus Data Service
/// Provides NCERT syllabus data for classes 6-12.
class SyllabusService {
  /// Get all subjects for a given class
  List<SubjectModel> getSubjects(String studentClass) {
    return _allSyllabus[studentClass] ?? _getDefaultSubjects();
  }

  /// Get all available classes
  List<String> get classes => _allSyllabus.keys.toList()..sort();

  /// Search chapters across all subjects
  List<ChapterModel> search(String query, String studentClass) {
    if (query.isEmpty) return [];
    final results = <ChapterModel>[];
    final subjects = getSubjects(studentClass);
    final lowerQuery = query.toLowerCase();

    for (final subject in subjects) {
      for (final chapter in subject.chapters) {
        if (chapter.title.toLowerCase().contains(lowerQuery) ||
            chapter.titleHindi.contains(query)) {
          results.add(chapter);
        }
      }
    }
    return results;
  }

  List<SubjectModel> _getDefaultSubjects() {
    return [
      SubjectModel(
        id: 'math',
        name: 'Mathematics',
        nameHindi: 'गणित',
        icon: '📐',
        chapters: _mathChapters,
      ),
      SubjectModel(
        id: 'science',
        name: 'Science',
        nameHindi: 'विज्ञान',
        icon: '🔬',
        chapters: _scienceChapters,
      ),
    ];
  }

  // ─── Mock Syllabus Data ──────────────────────────────────

  final Map<String, List<SubjectModel>> _allSyllabus = {
    'Class 6': [
      SubjectModel(
        id: 'math_6',
        name: 'Mathematics',
        nameHindi: 'गणित',
        icon: '📐',
        chapters: [
          ChapterModel(id: 'm6_1', title: 'Knowing Our Numbers', titleHindi: 'अपनी संख्याओं को जानना', chapterNumber: '1', questionCount: 24),
          ChapterModel(id: 'm6_2', title: 'Whole Numbers', titleHindi: 'पूर्ण संख्याएं', chapterNumber: '2', questionCount: 20),
          ChapterModel(id: 'm6_3', title: 'Playing with Numbers', titleHindi: 'संख्याओं के साथ खेलना', chapterNumber: '3', questionCount: 28),
          ChapterModel(id: 'm6_4', title: 'Basic Geometrical Ideas', titleHindi: 'मूल ज्यामितीय अवधारणाएं', chapterNumber: '4', questionCount: 18),
          ChapterModel(id: 'm6_5', title: 'Understanding Elementary Shapes', titleHindi: 'प्रारंभिक आकारों को समझना', chapterNumber: '5', questionCount: 22),
          ChapterModel(id: 'm6_6', title: 'Integers', titleHindi: 'पूर्णांक', chapterNumber: '6', questionCount: 16),
          ChapterModel(id: 'm6_7', title: 'Fractions', titleHindi: 'भिन्न', chapterNumber: '7', questionCount: 30),
          ChapterModel(id: 'm6_8', title: 'Decimals', titleHindi: 'दशमलव', chapterNumber: '8', questionCount: 26),
          ChapterModel(id: 'm6_9', title: 'Data Handling', titleHindi: 'आंकड़ों का प्रबंधन', chapterNumber: '9', questionCount: 14),
          ChapterModel(id: 'm6_10', title: 'Mensuration', titleHindi: 'क्षेत्रमिति', chapterNumber: '10', questionCount: 20),
          ChapterModel(id: 'm6_11', title: 'Algebra', titleHindi: 'बीजगणित', chapterNumber: '11', questionCount: 18),
          ChapterModel(id: 'm6_12', title: 'Ratio and Proportion', titleHindi: 'अनुपात और समानुपात', chapterNumber: '12', questionCount: 22),
        ],
      ),
      SubjectModel(
        id: 'sci_6',
        name: 'Science',
        nameHindi: 'विज्ञान',
        icon: '🔬',
        chapters: [
          ChapterModel(id: 's6_1', title: 'Food: Where Does It Come From?', titleHindi: 'भोजन: यह कहाँ से आता है?', chapterNumber: '1', questionCount: 12),
          ChapterModel(id: 's6_2', title: 'Components of Food', titleHindi: 'भोजन के घटक', chapterNumber: '2', questionCount: 16),
          ChapterModel(id: 's6_3', title: 'Fibre to Fabric', titleHindi: 'रेशे से वस्त्र तक', chapterNumber: '3', questionCount: 14),
          ChapterModel(id: 's6_4', title: 'Sorting Materials into Groups', titleHindi: 'वस्तुओं का समूहीकरण', chapterNumber: '4', questionCount: 18),
          ChapterModel(id: 's6_5', title: 'Separation of Substances', titleHindi: 'पदार्थों का पृथक्करण', chapterNumber: '5', questionCount: 20),
          ChapterModel(id: 's6_6', title: 'Changes Around Us', titleHindi: 'हमारे चारों ओर के परिवर्तन', chapterNumber: '6', questionCount: 12),
          ChapterModel(id: 's6_7', title: 'Getting to Know Plants', titleHindi: 'पौधों को जानना', chapterNumber: '7', questionCount: 16),
          ChapterModel(id: 's6_8', title: 'Body Movements', titleHindi: 'शरीर में गति', chapterNumber: '8', questionCount: 14),
          ChapterModel(id: 's6_9', title: 'The Living Organisms', titleHindi: 'सजीव एवं उनके लक्षण', chapterNumber: '9', questionCount: 18),
          ChapterModel(id: 's6_10', title: 'Motion and Measurement', titleHindi: 'गति एवं दूरियों का मापन', chapterNumber: '10', questionCount: 16),
          ChapterModel(id: 's6_11', title: 'Light, Shadows and Reflections', titleHindi: 'प्रकाश, छायाएं एवं परावर्तन', chapterNumber: '11', questionCount: 14),
          ChapterModel(id: 's6_12', title: 'Electricity and Circuits', titleHindi: 'विद्युत और परिपथ', chapterNumber: '12', questionCount: 16),
        ],
      ),
    ],
    'Class 7': [
      SubjectModel(
        id: 'math_7',
        name: 'Mathematics',
        nameHindi: 'गणित',
        icon: '📐',
        chapters: [
          ChapterModel(id: 'm7_1', title: 'Integers', titleHindi: 'पूर्णांक', chapterNumber: '1', questionCount: 20),
          ChapterModel(id: 'm7_2', title: 'Fractions and Decimals', titleHindi: 'भिन्न और दशमलव', chapterNumber: '2', questionCount: 28),
          ChapterModel(id: 'm7_3', title: 'Data Handling', titleHindi: 'आंकड़ों का प्रबंधन', chapterNumber: '3', questionCount: 16),
          ChapterModel(id: 'm7_4', title: 'Simple Equations', titleHindi: 'सरल समीकरण', chapterNumber: '4', questionCount: 22),
          ChapterModel(id: 'm7_5', title: 'Lines and Angles', titleHindi: 'रेखाएं और कोण', chapterNumber: '5', questionCount: 24),
          ChapterModel(id: 'm7_6', title: 'The Triangle and its Properties', titleHindi: 'त्रिभुज और उसके गुण', chapterNumber: '6', questionCount: 26),
          ChapterModel(id: 'm7_7', title: 'Comparing Quantities', titleHindi: 'राशियों की तुलना', chapterNumber: '7', questionCount: 20),
          ChapterModel(id: 'm7_8', title: 'Rational Numbers', titleHindi: 'परिमेय संख्याएं', chapterNumber: '8', questionCount: 18),
          ChapterModel(id: 'm7_9', title: 'Perimeter and Area', titleHindi: 'परिमाप और क्षेत्रफल', chapterNumber: '9', questionCount: 22),
          ChapterModel(id: 'm7_10', title: 'Algebraic Expressions', titleHindi: 'बीजीय व्यंजक', chapterNumber: '10', questionCount: 24),
          ChapterModel(id: 'm7_11', title: 'Exponents and Powers', titleHindi: 'घातांक और घात', chapterNumber: '11', questionCount: 16),
          ChapterModel(id: 'm7_12', title: 'Symmetry', titleHindi: 'सममिति', chapterNumber: '12', questionCount: 14),
        ],
      ),
      SubjectModel(
        id: 'sci_7',
        name: 'Science',
        nameHindi: 'विज्ञान',
        icon: '🔬',
        chapters: [
          ChapterModel(id: 's7_1', title: 'Nutrition in Plants', titleHindi: 'पादपों में पोषण', chapterNumber: '1', questionCount: 16),
          ChapterModel(id: 's7_2', title: 'Nutrition in Animals', titleHindi: 'जंतुओं में पोषण', chapterNumber: '2', questionCount: 18),
          ChapterModel(id: 's7_3', title: 'Heat', titleHindi: 'ऊष्मा', chapterNumber: '3', questionCount: 14),
          ChapterModel(id: 's7_4', title: 'Acids, Bases and Salts', titleHindi: 'अम्ल, क्षारक और लवण', chapterNumber: '4', questionCount: 20),
          ChapterModel(id: 's7_5', title: 'Physical and Chemical Changes', titleHindi: 'भौतिक एवं रासायनिक परिवर्तन', chapterNumber: '5', questionCount: 16),
          ChapterModel(id: 's7_6', title: 'Respiration in Organisms', titleHindi: 'जीवों में श्वसन', chapterNumber: '6', questionCount: 18),
          ChapterModel(id: 's7_7', title: 'Transportation in Animals', titleHindi: 'जंतुओं में परिवहन', chapterNumber: '7', questionCount: 20),
          ChapterModel(id: 's7_8', title: 'Reproduction in Plants', titleHindi: 'पादपों में जनन', chapterNumber: '8', questionCount: 14),
          ChapterModel(id: 's7_9', title: 'Motion and Time', titleHindi: 'गति और समय', chapterNumber: '9', questionCount: 16),
          ChapterModel(id: 's7_10', title: 'Electric Current', titleHindi: 'विद्युत धारा', chapterNumber: '10', questionCount: 18),
          ChapterModel(id: 's7_11', title: 'Light', titleHindi: 'प्रकाश', chapterNumber: '11', questionCount: 20),
          ChapterModel(id: 's7_12', title: 'Forests', titleHindi: 'वन', chapterNumber: '12', questionCount: 12),
        ],
      ),
    ],
    'Class 10': [
      SubjectModel(
        id: 'math_10',
        name: 'Mathematics',
        nameHindi: 'गणित',
        icon: '📐',
        totalChapters: 14,
        chapters: [
          ChapterModel(id: 'm10_1', title: 'Real Numbers', titleHindi: 'वास्तविक संख्याएं', chapterNumber: '1', questionCount: 18),
          ChapterModel(id: 'm10_2', title: 'Polynomials', titleHindi: 'बहुपद', chapterNumber: '2', questionCount: 20),
          ChapterModel(id: 'm10_3', title: 'Pair of Linear Equations', titleHindi: 'दो चरों में रैखिक समीकरण', chapterNumber: '3', questionCount: 24),
          ChapterModel(id: 'm10_4', title: 'Quadratic Equations', titleHindi: 'द्विघात समीकरण', chapterNumber: '4', questionCount: 22),
          ChapterModel(id: 'm10_5', title: 'Arithmetic Progressions', titleHindi: 'समांतर श्रेणियां', chapterNumber: '5', questionCount: 20),
          ChapterModel(id: 'm10_6', title: 'Triangles', titleHindi: 'त्रिभुज', chapterNumber: '6', questionCount: 26),
          ChapterModel(id: 'm10_7', title: 'Coordinate Geometry', titleHindi: 'निर्देशांक ज्यामिति', chapterNumber: '7', questionCount: 18),
          ChapterModel(id: 'm10_8', title: 'Introduction to Trigonometry', titleHindi: 'त्रिकोणमिति का परिचय', chapterNumber: '8', questionCount: 24),
          ChapterModel(id: 'm10_9', title: 'Some Applications of Trigonometry', titleHindi: 'त्रिकोणमिति के कुछ अनुप्रयोग', chapterNumber: '9', questionCount: 16),
          ChapterModel(id: 'm10_10', title: 'Circles', titleHindi: 'वृत्त', chapterNumber: '10', questionCount: 18),
          ChapterModel(id: 'm10_11', title: 'Areas Related to Circles', titleHindi: 'वृत्तों से संबंधित क्षेत्रफल', chapterNumber: '11', questionCount: 20),
          ChapterModel(id: 'm10_12', title: 'Surface Areas and Volumes', titleHindi: 'पृष्ठीय क्षेत्रफल और आयतन', chapterNumber: '12', questionCount: 22),
          ChapterModel(id: 'm10_13', title: 'Statistics', titleHindi: 'सांख्यिकी', chapterNumber: '13', questionCount: 16),
          ChapterModel(id: 'm10_14', title: 'Probability', titleHindi: 'प्रायिकता', chapterNumber: '14', questionCount: 14),
        ],
      ),
      SubjectModel(
        id: 'sci_10',
        name: 'Science',
        nameHindi: 'विज्ञान',
        icon: '🔬',
        chapters: [
          ChapterModel(id: 's10_1', title: 'Chemical Reactions and Equations', titleHindi: 'रासायनिक अभिक्रियाएं और समीकरण', chapterNumber: '1', questionCount: 24),
          ChapterModel(id: 's10_2', title: 'Acids, Bases and Salts', titleHindi: 'अम्ल, क्षारक और लवण', chapterNumber: '2', questionCount: 28),
          ChapterModel(id: 's10_3', title: 'Metals and Non-metals', titleHindi: 'धातु और अधातु', chapterNumber: '3', questionCount: 26),
          ChapterModel(id: 's10_4', title: 'Carbon and its Compounds', titleHindi: 'कार्बन और उसके यौगिक', chapterNumber: '4', questionCount: 30),
          ChapterModel(id: 's10_5', title: 'Life Processes', titleHindi: 'जीवन प्रक्रियाएं', chapterNumber: '5', questionCount: 32),
          ChapterModel(id: 's10_6', title: 'Control and Coordination', titleHindi: 'नियंत्रण एवं समन्वय', chapterNumber: '6', questionCount: 22),
          ChapterModel(id: 's10_7', title: 'Reproduction', titleHindi: 'जनन', chapterNumber: '7', questionCount: 26),
          ChapterModel(id: 's10_8', title: 'Heredity', titleHindi: 'आनुवंशिकता', chapterNumber: '8', questionCount: 18),
          ChapterModel(id: 's10_9', title: 'Light - Reflection and Refraction', titleHindi: 'प्रकाश - परावर्तन और अपवर्तन', chapterNumber: '9', questionCount: 30),
          ChapterModel(id: 's10_10', title: 'The Human Eye', titleHindi: 'मानव नेत्र', chapterNumber: '10', questionCount: 20),
          ChapterModel(id: 's10_11', title: 'Electricity', titleHindi: 'विद्युत', chapterNumber: '11', questionCount: 34),
          ChapterModel(id: 's10_12', title: 'Magnetic Effects of Current', titleHindi: 'विद्युत धारा के चुंबकीय प्रभाव', chapterNumber: '12', questionCount: 24),
          ChapterModel(id: 's10_13', title: 'Our Environment', titleHindi: 'हमारा पर्यावरण', chapterNumber: '13', questionCount: 16),
        ],
      ),
    ],
  };

  // Fallback chapters
  final _mathChapters = [
    ChapterModel(id: 'm1', title: 'Chapter 1', titleHindi: 'पाठ 1', chapterNumber: '1', questionCount: 20),
    ChapterModel(id: 'm2', title: 'Chapter 2', titleHindi: 'पाठ 2', chapterNumber: '2', questionCount: 18),
  ];

  final _scienceChapters = [
    ChapterModel(id: 's1', title: 'Chapter 1', titleHindi: 'पाठ 1', chapterNumber: '1', questionCount: 16),
    ChapterModel(id: 's2', title: 'Chapter 2', titleHindi: 'पाठ 2', chapterNumber: '2', questionCount: 20),
  ];
}
