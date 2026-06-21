import 'package:flutter/services.dart';

/// 📳 पढ़ो गुरु — Haptic Feedback Utility
class HapticUtil {
  /// Light tap — button press, card tap
  static void lightTap() {
    HapticFeedback.lightImpact();
  }

  /// Medium tap — camera capture, submit
  static void mediumTap() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy tap — achievements, celebrations
  static void heavyTap() {
    HapticFeedback.heavyImpact();
  }

  /// Selection click — dropdown, toggle
  static void selection() {
    HapticFeedback.selectionClick();
  }

  /// Error notification
  static void error() {
    HapticFeedback.mediumImpact();
  }
}
