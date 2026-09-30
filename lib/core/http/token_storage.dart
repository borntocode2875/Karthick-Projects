import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages Zoho OAuth2 tokens in flutter_secure_storage.
/// Keys are scoped per portal so multi-account works correctly.
class TokenStorage {
  TokenStorage() : _store = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final FlutterSecureStorage _store;

  static String _accessKey(String portalId) => 'at_$portalId';
  static String _refreshKey(String portalId) => 'rt_$portalId';
  static String _expiryKey(String portalId) => 'exp_$portalId';

  Future<void> save({
    required String portalId,
    required String accessToken,
    required String refreshToken,
    required DateTime expiry,
  }) async {
    await Future.wait([
      _store.write(key: _accessKey(portalId), value: accessToken),
      _store.write(key: _refreshKey(portalId), value: refreshToken),
      _store.write(key: _expiryKey(portalId), value: expiry.millisecondsSinceEpoch.toString()),
    ]);
  }

  Future<({String access, String refresh, DateTime expiry})?> load(String portalId) async {
    final results = await Future.wait([
      _store.read(key: _accessKey(portalId)),
      _store.read(key: _refreshKey(portalId)),
      _store.read(key: _expiryKey(portalId)),
    ]);
    final access = results[0];
    final refresh = results[1];
    final expiryMs = results[2];
    if (access == null || refresh == null || expiryMs == null) return null;
    return (
      access: access,
      refresh: refresh,
      expiry: DateTime.fromMillisecondsSinceEpoch(int.parse(expiryMs)),
    );
  }

  Future<void> delete(String portalId) async {
    await Future.wait([
      _store.delete(key: _accessKey(portalId)),
      _store.delete(key: _refreshKey(portalId)),
      _store.delete(key: _expiryKey(portalId)),
    ]);
  }
}
