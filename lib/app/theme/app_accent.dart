import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// AccentPreset
// ---------------------------------------------------------------------------

/// Built-in accent colour presets for Zoho Support Hub.
enum AccentPreset {
  blue,
  violet,
  teal,
  green,
  orange,
  rose;

  /// Human-readable display label.
  String get label {
    switch (this) {
      case AccentPreset.blue:
        return 'Blue';
      case AccentPreset.violet:
        return 'Violet';
      case AccentPreset.teal:
        return 'Teal';
      case AccentPreset.green:
        return 'Green';
      case AccentPreset.orange:
        return 'Orange';
      case AccentPreset.rose:
        return 'Rose';
    }
  }

  /// The light-mode primary colour for this preset.
  Color get lightPrimary {
    switch (this) {
      case AccentPreset.blue:
        return const Color(0xFF2F5BEA);
      case AccentPreset.violet:
        return const Color(0xFF6D4AE0);
      case AccentPreset.teal:
        return const Color(0xFF0F7B6C);
      case AccentPreset.green:
        return const Color(0xFF1F8A4C);
      case AccentPreset.orange:
        return const Color(0xFFC8520E);
      case AccentPreset.rose:
        return const Color(0xFFD1335B);
    }
  }

  /// The dark-mode primary colour for this preset.
  Color get darkPrimary {
    switch (this) {
      case AccentPreset.blue:
        return const Color(0xFF6E8BFF);
      case AccentPreset.violet:
        return const Color(0xFFA08BFF);
      case AccentPreset.teal:
        return const Color(0xFF3CC2AE);
      case AccentPreset.green:
        return const Color(0xFF4CC985);
      case AccentPreset.orange:
        return const Color(0xFFFF8A4C);
      case AccentPreset.rose:
        return const Color(0xFFFF7196);
    }
  }

  /// Light-mode soft (tinted surface) colour.
  Color get softLight {
    switch (this) {
      case AccentPreset.blue:
        return const Color(0xFFE9EEFD);
      case AccentPreset.violet:
        return const Color(0xFFEFEBFD);
      case AccentPreset.teal:
        return const Color(0xFFE2F3F0);
      case AccentPreset.green:
        return const Color(0xFFE4F3EA);
      case AccentPreset.orange:
        return const Color(0xFFFCEDE3);
      case AccentPreset.rose:
        return const Color(0xFFFCE8ED);
    }
  }

  /// Dark-mode soft (tinted surface) colour.
  Color get softDark {
    switch (this) {
      case AccentPreset.blue:
        return const Color(0xFF1D2442);
      case AccentPreset.violet:
        return const Color(0xFF251E40);
      case AccentPreset.teal:
        return const Color(0xFF11302B);
      case AccentPreset.green:
        return const Color(0xFF13291C);
      case AccentPreset.orange:
        return const Color(0xFF33200F);
      case AccentPreset.rose:
        return const Color(0xFF33161F);
    }
  }
}

// ---------------------------------------------------------------------------
// Custom accent derivation helpers
// ---------------------------------------------------------------------------

/// Returns the relative luminance of [color] per WCAG 2.1.
double _luminance(Color color) {
  double linearize(double c) =>
      c <= 0.04045 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
  final r = linearize(color.r);
  final g = linearize(color.g);
  final b = linearize(color.b);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

/// WCAG contrast ratio between [a] and [b].
double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  final lighter = math.max(la, lb);
  final darker = math.min(la, lb);
  return (lighter + 0.05) / (darker + 0.05);
}

/// Adjusts the HSL lightness of [color] in steps until [predicate] is satisfied,
/// or until the search exhausts [maxSteps].
Color _adjustLightness(
  Color color,
  bool Function(Color) predicate, {
  required bool increase,
  double stepSize = 0.02,
  int maxSteps = 50,
}) {
  final hsl = HSLColor.fromColor(color);
  var current = hsl;
  for (var i = 0; i < maxSteps; i++) {
    final next = current.withLightness(
      (current.lightness + (increase ? stepSize : -stepSize)).clamp(0.0, 1.0),
    );
    if (predicate(next.toColor())) return next.toColor();
    current = next;
  }
  return current.toColor();
}

/// Derives a light-mode primary that achieves ≥4.5:1 contrast against white.
Color _deriveLightPrimary(Color base) {
  const white = Color(0xFFFFFFFF);
  if (_contrast(base, white) >= 4.5) return base;
  // Need to darken
  return _adjustLightness(base, (c) => _contrast(c, white) >= 4.5, increase: false);
}

/// Derives a dark-mode primary that achieves ≥5:1 contrast against #0E0F12.
Color _deriveDarkPrimary(Color base) {
  const darkBg = Color(0xFF0E0F12);
  if (_contrast(base, darkBg) >= 5.0) return base;
  // Need to lighten
  return _adjustLightness(base, (c) => _contrast(c, darkBg) >= 5.0, increase: true);
}

/// Soft light: mix toward #F7F7F5 at 85%.
Color _softLight(Color primary) =>
    Color.lerp(primary, const Color(0xFFF7F7F5), 0.85)!;

/// Soft dark: mix toward #0E0F12 at 85%.
Color _softDark(Color primary) =>
    Color.lerp(primary, const Color(0xFF0E0F12), 0.85)!;

// ---------------------------------------------------------------------------
// AppAccentColors — ThemeExtension
// ---------------------------------------------------------------------------

/// Resolved accent colour set injected into the theme.
@immutable
class AppAccentColors extends ThemeExtension<AppAccentColors> {
  const AppAccentColors({
    required this.primary,
    required this.primaryDark,
    required this.soft,
    required this.softDark,
  });

  /// Light-mode accent primary.
  final Color primary;

  /// Dark-mode accent primary.
  final Color primaryDark;

  /// Light-mode soft (tinted surface).
  final Color soft;

  /// Dark-mode soft (tinted surface).
  final Color softDark;

  // -------------------------------------------------------------------------
  // Factories
  // -------------------------------------------------------------------------

  /// Build from a built-in [AccentPreset].
  factory AppAccentColors.fromPreset(AccentPreset preset) {
    return AppAccentColors(
      primary: preset.lightPrimary,
      primaryDark: preset.darkPrimary,
      soft: preset.softLight,
      softDark: preset.softDark,
    );
  }

  /// Build from a custom [Color], deriving all four variants automatically.
  factory AppAccentColors.fromCustomColor(Color color) {
    final light = _deriveLightPrimary(color);
    final dark = _deriveDarkPrimary(color);
    return AppAccentColors(
      primary: light,
      primaryDark: dark,
      soft: _softLight(light),
      softDark: _softDark(dark),
    );
  }

  // -------------------------------------------------------------------------
  // Convenience accessor
  // -------------------------------------------------------------------------

  static AppAccentColors of(BuildContext context) {
    return Theme.of(context).extension<AppAccentColors>() ??
        AppAccentColors.fromPreset(AccentPreset.blue);
  }

  // -------------------------------------------------------------------------
  // ThemeExtension overrides
  // -------------------------------------------------------------------------

  @override
  AppAccentColors copyWith({
    Color? primary,
    Color? primaryDark,
    Color? soft,
    Color? softDark,
  }) {
    return AppAccentColors(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      soft: soft ?? this.soft,
      softDark: softDark ?? this.softDark,
    );
  }

  @override
  AppAccentColors lerp(AppAccentColors? other, double t) {
    if (other == null) return this;
    return AppAccentColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      soft: Color.lerp(soft, other.soft, t)!,
      softDark: Color.lerp(softDark, other.softDark, t)!,
    );
  }
}
