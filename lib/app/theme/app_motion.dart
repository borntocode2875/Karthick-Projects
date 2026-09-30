import 'package:flutter/material.dart';

/// Duration tokens.
@immutable
class AppDurations {
  const AppDurations._();

  /// Tiny feedback animations (ripple, icon swap).
  static const Duration micro = Duration(milliseconds: 150);

  /// Most transitions (fade, size, colour).
  static const Duration standard = Duration(milliseconds: 250);

  /// Full-screen route transitions.
  static const Duration screen = Duration(milliseconds: 350);
}

/// Curve tokens.
@immutable
class AppCurves {
  const AppCurves._();

  /// Standard ease-in-out for most transitions.
  static const Curve standard = Curves.easeInOut;

  /// Decelerate — elements entering the screen.
  static const Curve decelerate = Curves.easeOut;

  /// Accelerate — elements leaving the screen.
  static const Curve accelerate = Curves.easeIn;

  /// Springy feel for sheets and confirmations.
  static const Curve spring = Curves.easeInOutCubic;
}

/// Detects whether the user has requested reduced motion via
/// [MediaQueryData.disableAnimations].
///
/// Usage:
/// ```dart
/// final reduced = ReducedMotion.of(context);
/// final duration = reduced ? Duration.zero : AppDurations.standard;
/// ```
abstract final class ReducedMotion {
  /// Returns `true` if the platform accessibility setting requests reduced
  /// motion (i.e., [MediaQueryData.disableAnimations] is `true`).
  static bool of(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Returns [AppDurations.standard] or [Duration.zero] based on the
  /// reduced-motion preference.
  static Duration standard(BuildContext context) =>
      of(context) ? Duration.zero : AppDurations.standard;

  /// Returns [AppDurations.screen] or [Duration.zero] based on the
  /// reduced-motion preference.
  static Duration screen(BuildContext context) =>
      of(context) ? Duration.zero : AppDurations.screen;
}
