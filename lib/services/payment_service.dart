import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../config/constants.dart';

/// पढ़ो गुरु — Payment Service (Google Play + Apple IAP)
class PaymentService {
  final InAppPurchase _purchase = InAppPurchase.instance;
  bool _isAvailable = false;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  // ─── Initialize ───────────────────────────────────────────
  Future<bool> initialize() async {
    try {
      _isAvailable = await _purchase.isAvailable();
      if (_isAvailable) {
        _subscription = _purchase.purchaseStream.listen(_onPurchaseUpdate);
      }
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
    }
    return _isAvailable;
  }

  // ─── Products ─────────────────────────────────────────────
  Future<List<ProductDetails>> getProducts() async {
    if (!_isAvailable) return [];

    final response = await _purchase.queryProductDetails({
      AppConstants.monthlyProductId,
      AppConstants.yearlyProductId,
    });
    return response.productDetails;
  }

  // ─── Purchase ─────────────────────────────────────────────
  Future<bool> purchaseProduct(String productId) async {
    if (!_isAvailable) return false;

    final products = await getProducts();
    final product = products.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('Product not found'),
    );

    final purchaseParam = PurchaseParam(productDetails: product);
    await _purchase.buyNonConsumable(purchaseParam: purchaseParam);
    return true;
  }

  // ─── Purchase Update Handler ──────────────────────────────
  void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        // Grant subscription
        _handlePurchase(purchase);
      } else if (purchase.status == PurchaseStatus.error) {
        // Handle error
      }
      if (purchase.pendingCompletePurchase) {
        _purchase.completePurchase(purchase);
      }
    }
  }

  void _handlePurchase(PurchaseDetails purchase) {
    // TODO: Verify purchase server-side and update user subscription
    // For now, local completion is enough for development
  }

  // ─── Restore Purchases ────────────────────────────────────
  Future<bool> restorePurchases() async {
    if (!_isAvailable) return false;
    await _purchase.restorePurchases();
    return true;
  }

  // ─── Dispose ──────────────────────────────────────────────
  void dispose() {
    _subscription?.cancel();
  }
}
