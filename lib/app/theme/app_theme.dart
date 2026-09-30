import 'package:flutter/material.dart';
import 'package:zoho_support_hub/app/theme/app_accent.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_text_theme.dart';

/// Factory that produces a matched pair of [ThemeData] (light + dark).
abstract final class AppTheme {
  /// Builds the light [ThemeData] for [accentColors].
  static ThemeData light(AppAccentColors accentColors) {
    return _build(
      colors: AppColors.light,
      accentColors: accentColors,
      brightness: Brightness.light,
      primary: accentColors.primary,
    );
  }

  /// Builds the dark [ThemeData] for [accentColors].
  static ThemeData dark(AppAccentColors accentColors) {
    return _build(
      colors: AppColors.dark,
      accentColors: accentColors,
      brightness: Brightness.dark,
      primary: accentColors.primaryDark,
    );
  }

  static ThemeData _build({
    required AppColors colors,
    required AppAccentColors accentColors,
    required Brightness brightness,
    required Color primary,
  }) {
    final textTheme = AppTextTheme.build(color: colors.textPrimary);

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: brightness == Brightness.light
          ? accentColors.soft
          : accentColors.softDark,
      onPrimaryContainer: primary,
      secondary: primary,
      onSecondary: Colors.white,
      secondaryContainer: brightness == Brightness.light
          ? accentColors.soft
          : accentColors.softDark,
      onSecondaryContainer: primary,
      tertiary: primary,
      onTertiary: Colors.white,
      tertiaryContainer: brightness == Brightness.light
          ? accentColors.soft
          : accentColors.softDark,
      onTertiaryContainer: primary,
      error: colors.danger,
      onError: Colors.white,
      errorContainer: brightness == Brightness.light
          ? const Color(0xFFFCE8ED)
          : const Color(0xFF33161F),
      onErrorContainer: colors.danger,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      surfaceContainerHighest: colors.raised,
      onSurfaceVariant: colors.textSecondary,
      outline: colors.line,
      outlineVariant: colors.line,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: brightness == Brightness.light
          ? AppColors.dark.surface
          : AppColors.light.surface,
      onInverseSurface: brightness == Brightness.light
          ? AppColors.dark.textPrimary
          : AppColors.light.textPrimary,
      inversePrimary: brightness == Brightness.light
          ? accentColors.primaryDark
          : accentColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        colors,
        accentColors,
      ],
      // Suppress seed-colour overrides — we control the palette entirely.
      colorSchemeSeed: null,
      // Card theme
      cardTheme: CardThemeData(
        color: colors.raised,
        surfaceTintColor: Colors.transparent,
        elevation: brightness == Brightness.light ? 1 : 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      // Navigation bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: brightness == Brightness.light
            ? accentColors.soft
            : accentColors.softDark,
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colors.textSecondary,
          ),
        ),
      ),
      // Divider
      dividerTheme: DividerThemeData(
        color: colors.line,
        thickness: 1,
        space: 1,
      ),
      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: colors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: colors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: colors.danger),
        ),
        labelStyle: TextStyle(color: colors.textSecondary),
        hintStyle: TextStyle(color: colors.textTertiary),
      ),
      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: BorderSide(color: colors.line),
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          color: colors.textPrimary,
        ),
      ),
      // Floating action button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
      ),
      // Bottom sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }
}
