enum AppEnv { mock, live }

class AppConfig {
  const AppConfig._();

  static const String _envRaw =
      String.fromEnvironment('APP_ENV', defaultValue: 'mock');

  static AppEnv get env =>
      _envRaw == 'live' ? AppEnv.live : AppEnv.mock;

  static bool get isMock => env == AppEnv.mock;
  static bool get isLive => env == AppEnv.live;
}
