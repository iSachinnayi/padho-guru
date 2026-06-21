/// पढ़ो गुरु — App Constants
class AppConstants {
  AppConstants._();

  // ─── App Info ─────────────────────────────────────────────
  static const String appName = 'पढ़ो गुरु';
  static const String appNameEn = 'Padho Guru';
  static const String storeTitle = 'NCERT AI Tutor: Study Solver';
  static const String tagline =
      'NCERT का AI Tutor — फोटो खींचो, हिंदी में समझो';
  static const String taglineEn = 'Click photo, get Hindi answer instantly!';

  // ─── Pricing ───────────────────────────────────────────────
  static const int freeQuestionsPerDay = 5;
  static const int monthlyPriceINR = 99;
  static const int yearlyPriceINR = 999;
  static const int familyPriceINR = 199;
  static const int trialDays = 3;
  static const int yearlyTrialDays = 7;

  // ─── Subscription Product IDs ──────────────────────────────
  static const String monthlyProductId = 'padho_guru_monthly';
  static const String yearlyProductId = 'padho_guru_yearly';
  static const String familyProductId = 'padho_guru_family';

  // ─── Firestore Collections ─────────────────────────────────
  static const String usersCollection = 'users';
  static const String cachedAnswersCollection = 'cached_answers';
  static const String historyCollection = 'history';
  static const String bookmarksCollection = 'bookmarks';

  // ─── SharedPreferences Keys ────────────────────────────────
  static const String prefOnboardingDone = 'onboarding_done';
  static const String prefSelectedClass = 'selected_class';
  static const String prefSelectedBoard = 'selected_board';
  static const String prefQuestionsToday = 'questions_today';
  static const String prefLastActiveDate = 'last_active_date';
  static const String prefStreakCount = 'streak_count';

  // ─── NCERT Classes ─────────────────────────────────────────
  static const List<String> ncertClasses = [
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
    'Class 11',
    'Class 12',
  ];

  // ─── Subjects ──────────────────────────────────────────────
  static const Map<String, List<String>> subjectsByClass = {
    'Class 6': [
      'Mathematics',
      'Science',
      'Social Science',
      'Hindi',
      'English',
      'Sanskrit',
    ],
    'Class 7': [
      'Mathematics',
      'Science',
      'Social Science',
      'Hindi',
      'English',
      'Sanskrit',
    ],
    'Class 8': [
      'Mathematics',
      'Science',
      'Social Science',
      'Hindi',
      'English',
      'Sanskrit',
    ],
    'Class 9': [
      'Mathematics',
      'Science',
      'Social Science',
      'Hindi',
      'English',
      'Sanskrit',
    ],
    'Class 10': [
      'Mathematics',
      'Science',
      'Social Science',
      'Hindi',
      'English',
      'Sanskrit',
    ],
    'Class 11': [
      'Physics',
      'Chemistry',
      'Biology',
      'Mathematics',
      'Hindi',
      'English',
      'History',
      'Geography',
      'Political Science',
      'Economics',
      'Accountancy',
      'Business Studies',
    ],
    'Class 12': [
      'Physics',
      'Chemistry',
      'Biology',
      'Mathematics',
      'Hindi',
      'English',
      'History',
      'Geography',
      'Political Science',
      'Economics',
      'Accountancy',
      'Business Studies',
    ],
  };

  // ─── Boards ────────────────────────────────────────────────
  static const List<String> boards = [
    'CBSE',
    'UP Board',
    'Bihar Board',
    'MP Board',
    'Rajasthan Board',
    'Maharashtra Board',
    'Gujarat Board',
    'West Bengal Board',
    'Other State Board',
  ];

  // ─── Image Config ──────────────────────────────────────────
  static const double imageMaxWidth = 1080;
  static const int imageQuality = 70;

  // ─── Animation ─────────────────────────────────────────────
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration chatMessageDuration = Duration(milliseconds: 250);
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
  static const Duration splashDuration = Duration(milliseconds: 1500);
}
