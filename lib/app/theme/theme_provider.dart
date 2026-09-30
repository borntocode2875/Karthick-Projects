import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoho_support_hub/app/theme/app_accent.dart';
import 'package:zoho_support_hub/app/theme/app_theme.dart';

// ---------------------------------------------------------------------------
// Preference keys
// ---------------------------------------------------------------------------

const String _keyThemeMode = 'theme_mode';
const String _keyAccentPreset = 'accent_preset';
const String _keyCustomAccentColor = 'custom_accent_color';

// ---------------------------------------------------------------------------
// ThemePreferencesService
// ---------------------------------------------------------------------------

/// Reads and writes theme preferences to [SharedPreferences].
class ThemePreferencesService {
  const ThemePreferencesService(this._prefs);

  final SharedPreferences _prefs;

  // ThemeMode ----------------------------------------------------------------

  ThemeMode readThemeMode() {
    final raw = _prefs.getString(_keyThemeMode);
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> writeThemeMode(ThemeMode mode) async {
    final raw = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(_keyThemeMode, raw);
  }

  // AccentPreset -------------------------------------------------------------

  AccentPreset readAccentPreset() {
    final raw = _prefs.getString(_keyAccentPreset);
    return AccentPreset.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => AccentPreset.blue,
    );
  }

  Future<void> writeAccentPreset(AccentPreset preset) async {
    await _prefs.setString(_keyAccentPreset, preset.name);
  }

  // Custom accent colour -----------------------------------------------------

  Color? readCustomAccentColor() {
    final hex = _prefs.getString(_keyCustomAccentColor);
    if (hex == null) return null;
    final value = int.tryParse(hex, radix: 16);
    if (value == null) return null;
    return Color(value);
  }

  Future<void> writeCustomAccentColor(Color? color) async {
    if (color == null) {
      await _prefs.remove(_keyCustomAccentColor);
    } else {
      await _prefs.setString(
        _keyCustomAccentColor,
        color.toARGB32().toRadixString(16).padLeft(8, '0'),
      );
    }
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

/// Provides an initialised [SharedPreferences] instance.
///
/// Must be overridden in [ProviderScope] before use:
/// ```dart
/// ProviderScope(
///   overrides: [
///     sharedPreferencesProvider.overrideWithValue(await SharedPreferences.getInstance()),
///   ],
///   ...
/// )
/// ```
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider not overridden'),
);

/// Provides the [ThemePreferencesService].
final themePreferencesServiceProvider = Provider<ThemePreferencesService>((ref) {
  return ThemePreferencesService(ref.watch(sharedPreferencesProvider));
});

// ---------------------------------------------------------------------------
// Theme mode
// ---------------------------------------------------------------------------

class _ThemeModeNotifier extends StateNotifier<ThemeMode> {
  _ThemeModeNotifier(this._service) : super(_service.readThemeMode());

  final ThemePreferencesService _service;

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await _service.writeThemeMode(mode);
  }
}

final themeModeProvider =
    StateNotifierProvider<_ThemeModeNotifier, ThemeMode>((ref) {
  return _ThemeModeNotifier(ref.watch(themePreferencesServiceProvider));
});

// ---------------------------------------------------------------------------
// Accent preset
// ---------------------------------------------------------------------------

class _AccentPresetNotifier extends StateNotifier<AccentPreset> {
  _AccentPresetNotifier(this._service) : super(_service.readAccentPreset());

  final ThemePreferencesService _service;

  Future<void> setPreset(AccentPreset preset) async {
    state = preset;
    await _service.writeAccentPreset(preset);
  }
}

final accentPresetProvider =
    StateNotifierProvider<_AccentPresetNotifier, AccentPreset>((ref) {
  return _AccentPresetNotifier(ref.watch(themePreferencesServiceProvider));
});

// ---------------------------------------------------------------------------
// Custom accent colour
// ---------------------------------------------------------------------------

class _CustomAccentColorNotifier extends StateNotifier<Color?> {
  _CustomAccentColorNotifier(this._service)
      : super(_service.readCustomAccentColor());

  final ThemePreferencesService _service;

  Future<void> setColor(Color? color) async {
    state = color;
    await _service.writeCustomAccentColor(color);
  }
}

final customAccentColorProvider =
    StateNotifierProvider<_CustomAccentColorNotifier, Color?>((ref) {
  return _CustomAccentColorNotifier(ref.watch(themePreferencesServiceProvider));
});

// ---------------------------------------------------------------------------
// Resolved theme pair
// ---------------------------------------------------------------------------

/// Holds the derived light and dark [ThemeData] as a convenience record.
typedef ThemePair = ({ThemeData light, ThemeData dark});

/// Derives the final [ThemePair] from accent preset / custom colour.
final resolvedThemeProvider = Provider<ThemePair>((ref) {
  final preset = ref.watch(accentPresetProvider);
  final customColor = ref.watch(customAccentColorProvider);

  final accentColors = customColor != null
      ? AppAccentColors.fromCustomColor(customColor)
      : AppAccentColors.fromPreset(preset);

  return (
    light: AppTheme.light(accentColors),
    dark: AppTheme.dark(accentColors),
  );
});
