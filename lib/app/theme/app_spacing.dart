import 'package:flutter/foundation.dart';

/// Spacing tokens (logical pixels).
@immutable
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
  static const double xxxxl = 56;

  /// Horizontal margin applied to full-width screen content.
  static const double screenMargin = 20;
}

/// Border-radius tokens (logical pixels).
@immutable
class AppRadii {
  const AppRadii._();

  static const double chip = 8;
  static const double card = 14;
  static const double sheet = 20;
  static const double pill = 999;
  static const double fab = 999;
}
