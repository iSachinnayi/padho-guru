import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

/// पढ़ो गुरु — Firebase Phone Auth Service
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ─── Auth State Stream ────────────────────────────────────
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ─── Current User ─────────────────────────────────────────
  User? get currentUser => _auth.currentUser;

  // ─── Phone OTP ────────────────────────────────────────────
  /// Send OTP to phone number
  Future<ConfirmationResult> signInWithPhone(String phoneNumber) async {
    try {
      final result = await _auth.signInWithPhoneNumber(phoneNumber);
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Verify OTP
  Future<UserCredential> verifyOTP(
    ConfirmationResult confirmationResult,
    String otp,
  ) async {
    try {
      final credential = await confirmationResult.confirm(otp);
      // Create user document if new user
      if (credential.additionalUserInfo?.isNewUser ?? false) {
        await _createUserDocument(credential.user!);
      } else {
        // Update last active for existing user
        await _updateLastActive(credential.user!.uid);
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ─── User Document ────────────────────────────────────────
  Future<void> _createUserDocument(User user) async {
    final userData = UserModel(
      uid: user.uid,
      phone: user.phoneNumber ?? '',
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    );
    await _firestore.collection('users').doc(user.uid).set(userData.toJson());
  }

  Future<void> _updateLastActive(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'lastActive': DateTime.now().toIso8601String(),
    });
  }

  // ─── Get User Data ────────────────────────────────────────
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!, uid);
      }
      return null;
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
      return null;
    }
  }

  // ─── Update User ──────────────────────────────────────────
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  // ─── Sign Out ─────────────────────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ─── Error Handling ──────────────────────────────────────
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'कृपया सही फोन नंबर दर्ज करें';
      case 'too-many-requests':
        return 'बहुत अधिक प्रयास, कृपया थोड़ी देर में पुनः प्रयास करें';
      case 'session-expired':
        return 'OTP समय समाप्त हो गया, कृपया पुनः प्रयास करें';
      case 'invalid-verification-code':
        return 'गलत OTP, कृपया पुनः प्रयास करें';
      default:
        return 'कुछ गलत हो गया, कृपया पुनः प्रयास करें';
    }
  }
}
