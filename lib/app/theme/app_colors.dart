import 'package:flutter/material.dart';

/// Semantic color tokens for Zoho Support Hub.
///
/// Use [AppColors.of] to retrieve the current brightness-aware instance.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.raised,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.line,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.ziaGradientStart,
    required this.ziaGradientEnd,
  });

  final Color background;
  final Color surface;
  final Color raised;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color line;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final Color ziaGradientStart;
  final Color ziaGradientEnd;

  // -------------------------------------------------------------------------
  // Preset instances
  // -------------------------------------------------------------------------

  static const AppColors light = AppColors(
    background: Color(0xFFF7F7F5),
    surface: Color(0xFFFFFFFF),
    raised: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF16181D),
    textSecondary: Color(0xFF5B616E),
    textTertiary: Color(0xFF8A909C),
    line: Color(0xFFE6E7EA),
    success: Color(0xFF1F9D55),
    warning: Color(0xFFB87700),
    danger: Color(0xFFE0413A),
    info: Color(0xFF2F80ED),
    ziaGradientStart: Color(0xFF7B5CFA),
    ziaGradientEnd: Color(0xFF2F5BEA),
  );

  static const AppColors dark = AppColors(
    background: Color(0xFF0E0F12),
    surface: Color(0xFF17191E),
    raised: Color(0xFF1F2228),
    textPrimary: Color(0xFFF2F3F5),
    textSecondary: Color(0xFFA3A8B3),
    textTertiary: Color(0xFF737985),
    line: Color(0xFF2A2D34),
    success: Color(0xFF3DC47A),
    warning: Color(0xFFF0B429),
    danger: Color(0xFFFF6B63),
    info: Color(0xFF5EA0FF),
    ziaGradientStart: Color(0xFF7B5CFA),
    ziaGradientEnd: Color(0xFF2F5BEA),
  );

  // -------------------------------------------------------------------------
  // Convenience accessor
  // -------------------------------------------------------------------------

  /// Returns the [AppColors] registered in [context]'s theme.
  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>() ??
        (Theme.of(context).brightness == Brightness.dark ? dark : light);
  }

  // -------------------------------------------------------------------------
  // ThemeExtension overrides
  // -------------------------------------------------------------------------

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? raised,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? line,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? ziaGradientStart,
    Color? ziaGradientEnd,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      raised: raised ?? this.raised,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      line: line ?? this.line,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
      ziaGradientStart: ziaGradientStart ?? this.ziaGradientStart,
      ziaGradientEnd: ziaGradientEnd ?? this.ziaGradientEnd,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      raised: Color.lerp(raised, other.raised, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      line: Color.lerp(line, other.line, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      ziaGradientStart: Color.lerp(ziaGradientStart, other.ziaGradientStart, t)!,
      ziaGradientEnd: Color.lerp(ziaGradientEnd, other.ziaGradientEnd, t)!,
    );
  }
}
