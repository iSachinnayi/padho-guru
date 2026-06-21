/// पढ़ो गुरु — User Model
class UserModel {
  final String uid;
  final String phone;
  final String? name;
  final String? selectedClass;
  final String? board;
  final String? language;
  final int streak;
  final int totalQuestions;
  final int questionsToday;
  final DateTime? lastActiveDate;
  final SubscriptionPlan subscriptionPlan;
  final DateTime? subscriptionExpiry;
  final DateTime createdAt;
  final DateTime lastActive;

  UserModel({
    required this.uid,
    required this.phone,
    this.name,
    this.selectedClass,
    this.board,
    this.language,
    this.streak = 0,
    this.totalQuestions = 0,
    this.questionsToday = 0,
    this.lastActiveDate,
    this.subscriptionPlan = SubscriptionPlan.free,
    this.subscriptionExpiry,
    DateTime? createdAt,
    DateTime? lastActive,
  }) : createdAt = createdAt ?? DateTime.now(),
       lastActive = lastActive ?? DateTime.now();

  /// Check if user has active subscription
  bool get hasActiveSubscription {
    if (subscriptionPlan == SubscriptionPlan.free) return false;
    if (subscriptionExpiry == null) return false;
    return DateTime.now().isBefore(subscriptionExpiry!);
  }

  /// Check if user can ask questions today (free tier)
  bool get canAskFreeQuestion {
    if (hasActiveSubscription) return true;
    return questionsToday < 5;
  }

  /// Remaining free questions today
  int get remainingFreeQuestions {
    if (hasActiveSubscription) return -1; // unlimited
    return 5 - questionsToday;
  }

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phone': phone,
      'name': name ?? '',
      'class': selectedClass ?? '',
      'board': board ?? '',
      'language': language ?? 'hi',
      'streak': streak,
      'totalQuestions': totalQuestions,
      'questionsToday': questionsToday,
      'lastActiveDate':
          lastActiveDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'subscriptionPlan': subscriptionPlan.name,
      'subscriptionExpiry': subscriptionExpiry?.toIso8601String() ?? '',
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive.toIso8601String(),
    };
  }

  /// Create from Firestore JSON
  factory UserModel.fromJson(Map<String, dynamic> json, String uid) {
    return UserModel(
      uid: uid,
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      selectedClass: json['class'] ?? '',
      board: json['board'] ?? '',
      language: json['language'] ?? 'hi',
      streak: json['streak'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      questionsToday: json['questionsToday'] ?? 0,
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.tryParse(json['lastActiveDate'])
          : null,
      subscriptionPlan: SubscriptionPlan.values.firstWhere(
        (e) => e.name == (json['subscriptionPlan'] ?? 'free'),
        orElse: () => SubscriptionPlan.free,
      ),
      subscriptionExpiry: json['subscriptionExpiry'] != null
          ? DateTime.tryParse(json['subscriptionExpiry'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      lastActive: json['lastActive'] != null
          ? DateTime.parse(json['lastActive'])
          : DateTime.now(),
    );
  }

  /// Copy with modifications
  UserModel copyWith({
    String? name,
    String? selectedClass,
    String? board,
    String? language,
    int? streak,
    int? totalQuestions,
    int? questionsToday,
    DateTime? lastActiveDate,
    SubscriptionPlan? subscriptionPlan,
    DateTime? subscriptionExpiry,
    DateTime? lastActive,
  }) {
    return UserModel(
      uid: uid,
      phone: phone,
      name: name ?? this.name,
      selectedClass: selectedClass ?? this.selectedClass,
      board: board ?? this.board,
      language: language ?? this.language,
      streak: streak ?? this.streak,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      questionsToday: questionsToday ?? this.questionsToday,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
      createdAt: createdAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}

/// Subscription Plan Enum
enum SubscriptionPlan {
  free('free'),
  monthly('monthly'),
  yearly('yearly');

  final String name;
  const SubscriptionPlan(this.name);
}
