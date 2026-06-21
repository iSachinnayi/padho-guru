import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

/// पढ़ो गुरु — Firestore Database Service
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─── User Operations ─────────────────────────────────────
  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!, uid);
    }
    return null;
  }

  // ─── Chat History ────────────────────────────────────────
  Future<void> saveChatHistory(String uid, Map<String, dynamic> data) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('history')
        .add(data);
  }

  Stream<QuerySnapshot> getChatHistory(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('history')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ─── Bookmarks ───────────────────────────────────────────
  Future<void> toggleBookmark(String uid, String answerId, bool bookmarked) async {
    if (bookmarked) {
      await _db
          .collection('users')
          .doc(uid)
          .collection('bookmarks')
          .doc(answerId)
          .set({'answerId': answerId, 'createdAt': DateTime.now().toIso8601String()});
    } else {
      await _db
          .collection('users')
          .doc(uid)
          .collection('bookmarks')
          .doc(answerId)
          .delete();
    }
  }

  // ─── Cached Answers ──────────────────────────────────────
  Future<Map<String, dynamic>?> getCachedAnswer(String hash) async {
    final doc = await _db.collection('cached_answers').doc(hash).get();
    if (doc.exists && doc.data() != null) {
      // Increment times asked
      await _db.collection('cached_answers').doc(hash).update({
        'timesAsked': FieldValue.increment(1),
        'lastAsked': DateTime.now().toIso8601String(),
      });
      return doc.data();
    }
    return null;
  }

  Future<void> cacheAnswer(Map<String, dynamic> data) async {
    await _db.collection('cached_answers').doc(data['hash']).set(data);
  }

  // ─── Question Count / Streak ─────────────────────────────
  Future<void> incrementQuestionCount(String uid) async {
    final userRef = _db.collection('users').doc(uid);
    await userRef.update({
      'totalQuestions': FieldValue.increment(1),
      'questionsToday': FieldValue.increment(1),
      'lastActive': DateTime.now().toIso8601String(),
    });
  }
}
