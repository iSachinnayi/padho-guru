import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/payment_service.dart';

/// पढ़ो गुरु — Subscription State Provider
class SubscriptionProvider extends ChangeNotifier {
  final PaymentService _paymentService = PaymentService();

  SubscriptionPlan _currentPlan = SubscriptionPlan.free;
  bool _isLoading = false;
  bool _isInitialized = false;

  SubscriptionPlan get currentPlan => _currentPlan;
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  bool get hasActiveSubscription => _currentPlan != SubscriptionPlan.free;

  // ─── Initialize ───────────────────────────────────────────
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _isInitialized = await _paymentService.initialize();

    _isLoading = false;
    notifyListeners();
  }

  // ─── Purchase Monthly ─────────────────────────────────────
  Future<bool> purchaseMonthly() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _paymentService.purchaseProduct('padho_guru_monthly');
      _currentPlan = SubscriptionPlan.monthly;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ─── Purchase Yearly ──────────────────────────────────────
  Future<bool> purchaseYearly() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _paymentService.purchaseProduct('padho_guru_yearly');
      _currentPlan = SubscriptionPlan.yearly;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ─── Restore Purchases ────────────────────────────────────
  Future<void> restorePurchases() async {
    await _paymentService.restorePurchases();
  }

  // ─── Set Plan (for testing) ──────────────────────────────
  void setPlan(SubscriptionPlan plan) {
    _currentPlan = plan;
    notifyListeners();
  }
}
