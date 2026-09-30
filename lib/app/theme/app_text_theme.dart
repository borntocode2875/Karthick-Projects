import 'package:flutter/material.dart';

/// Builds the app [TextTheme] using the Inter font family.
///
/// All sizes are in logical pixels (sp = dp on most devices).
abstract final class AppTextTheme {
  static const String _fontFamily = 'Inter';

  /// Constructs the full [TextTheme]. Pass [color] for the base text colour
  /// so Material can compute contrasting colours automatically.
  static TextTheme build({required Color color}) {
    return TextTheme(
      // display — 32sp / h38 / w600 / -2% tracking
      displayLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        height: 38 / 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 32 * -0.02, // -2%
        color: color,
      ),

      // title — 22sp / h28 / w600
      titleLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w600,
        color: color,
      ),

      // headline — 17sp / h24 / w600
      headlineMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 17,
        height: 24 / 17,
        fontWeight: FontWeight.w600,
        color: color,
      ),

      // body — 16sp / h24 / w400
      bodyLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
        color: color,
      ),

      // callout — 15sp / h22
      bodyMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 15,
        height: 22 / 15,
        fontWeight: FontWeight.w400,
        color: color,
      ),

      // caption — 13sp / h18
      bodySmall: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w400,
        color: color,
      ),

      // label — 12sp / h16 / w500
      labelSmall: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
