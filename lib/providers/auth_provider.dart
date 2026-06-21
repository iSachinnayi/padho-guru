import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

/// पढ़ो गुरु — Authentication State Provider
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  // ─── State ────────────────────────────────────────────────
  UserModel? _user;
  bool _isLoading = false;
  String? _error;
  ConfirmationResult? _confirmationResult;

  // ─── Getters ──────────────────────────────────────────────
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;
  bool get isVerified => _authService.currentUser != null;
  ConfirmationResult? get confirmationResult => _confirmationResult;

  // ─── Initialization ───────────────────────────────────────
  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser != null) {
      _isLoading = true;
      notifyListeners();
      _user = await _authService.getUserData(firebaseUser.uid);
      _isLoading = false;
      notifyListeners();
    } else {
      _user = null;
      notifyListeners();
    }
  }

  // ─── Send OTP ─────────────────────────────────────────────
  Future<bool> sendOTP(String phoneNumber) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _confirmationResult = await _authService.signInWithPhone(phoneNumber);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ─── Verify OTP ───────────────────────────────────────────
  Future<bool> verifyOTP(String otp) async {
    if (_confirmationResult == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.verifyOTP(_confirmationResult!, otp);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ─── Update Profile ───────────────────────────────────────
  Future<void> updateProfile({
    String? name,
    String? selectedClass,
    String? board,
  }) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (selectedClass != null) data['class'] = selectedClass;
      if (board != null) data['board'] = board;

      if (data.isNotEmpty) {
        await _authService.updateUserData(_user!.uid, data);
        _user = _user!.copyWith(
          name: name,
          selectedClass: selectedClass,
          board: board,
        );
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ─── Sign Out ─────────────────────────────────────────────
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // ─── Clear Error ──────────────────────────────────────────
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
