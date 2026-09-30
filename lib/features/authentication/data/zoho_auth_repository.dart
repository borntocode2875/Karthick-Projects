import 'package:dio/dio.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/http/token_storage.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/accounts/domain/user_profile.dart';
import 'package:zoho_support_hub/features/authentication/domain/auth_repository.dart';

/// Zoho OAuth2 (password-credentials grant) implementation.
///
/// In production the app would use PKCE via an in-app browser. For Phase 2
/// we use the password-grant flow so the existing login UI works unchanged.
/// Replace with PKCE when the OAuth redirect URI is registered with Zoho.
class ZohoAuthRepository implements AuthRepository {
  ZohoAuthRepository({required this.tokenStorage}) : _oauthDio = _buildOAuthDio();

  final TokenStorage tokenStorage;
  final Dio _oauthDio;

  static Dio _buildOAuthDio() => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

  String _accountsDomain(DataCenter dc) {
    switch (dc) {
      case DataCenter.india:
        return 'accounts.zoho.in';
      case DataCenter.eu:
        return 'accounts.zoho.eu';
      case DataCenter.au:
        return 'accounts.zoho.com.au';
      case DataCenter.jp:
        return 'accounts.zoho.jp';
      case DataCenter.ca:
        return 'accounts.zohocloud.ca';
      case DataCenter.sa:
        return 'accounts.zoho.sa';
      case DataCenter.us:
        return 'accounts.zoho.com';
    }
  }

  @override
  Future<AccountContext> signIn({
    required String email,
    required String password,
    required DeskAccount account,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw const ValidationError('Email and password are required.');
    }

    final domain = _accountsDomain(account.dataCenter);
    try {
      final resp = await _oauthDio.post<Map<String, dynamic>>(
        'https://$domain/oauth/v2/token',
        data: {
          'grant_type': 'password',
          'username': email.trim(),
          'password': password,
          'client_id': const String.fromEnvironment('ZOHO_CLIENT_ID'),
          'scope': 'Desk.tickets.ALL,Desk.contacts.READ,Desk.settings.READ',
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final body = resp.data as Map<String, dynamic>;
      final accessToken = body['access_token'] as String;
      final refreshToken = body['refresh_token'] as String? ?? '';
      final expiresIn = (body['expires_in'] as num?)?.toInt() ?? 3600;

      await tokenStorage.save(
        portalId: account.portalId,
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiry: DateTime.now().add(Duration(seconds: expiresIn - 60)),
      );

      final profile = await _fetchProfile(account);
      final permissions = await resolvePermissions(user: profile, account: account);
      return AccountContext(user: profile, account: account, permissions: permissions);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 400 || status == 401) {
        throw const UnauthenticatedError('Invalid email or password.');
      }
      throw NetworkError(e.message ?? 'Network error during sign in.');
    }
  }

  @override
  Future<void> signOut(AccountContext context) async {
    await tokenStorage.delete(context.account.portalId);
  }

  @override
  Future<AccountContext?> restoreSession(DeskAccount account) async {
    final stored = await tokenStorage.load(account.portalId);
    if (stored == null) return null;

    final isExpired = stored.expiry.isBefore(DateTime.now());
    if (isExpired && stored.refresh.isEmpty) return null;

    if (isExpired) {
      try {
        await _refreshToken(account: account, refreshToken: stored.refresh);
      } catch (_) {
        await tokenStorage.delete(account.portalId);
        return null;
      }
    }

    try {
      final profile = await _fetchProfile(account);
      final permissions = await resolvePermissions(user: profile, account: account);
      return AccountContext(user: profile, account: account, permissions: permissions);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<TicketPermissions> resolvePermissions({
    required UserProfile user,
    required DeskAccount account,
  }) async {
    // Zoho Desk Help Center customers always get full self-service permissions.
    // Fine-grained control comes from portal configuration fetched separately.
    return TicketPermissions.full;
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<UserProfile> _fetchProfile(DeskAccount account) async {
    final stored = await tokenStorage.load(account.portalId);
    if (stored == null) throw const UnauthenticatedError();

    final resp = await _oauthDio.get<Map<String, dynamic>>(
      'https://${account.apiDomain}/api/v1/myprofile',
      options: Options(
        headers: {'Authorization': 'Zoho-oauthtoken ${stored.access}'},
      ),
    );
    final data = resp.data as Map<String, dynamic>;
    return UserProfile(
      id: data['id']?.toString() ?? '',
      name: data['fullName'] as String? ?? data['firstName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String?,
      avatarUrl: data['photoURL'] as String?,
      contactId: data['id']?.toString() ?? '',
    );
  }

  Future<void> _refreshToken({
    required DeskAccount account,
    required String refreshToken,
  }) async {
    final domain = _accountsDomain(account.dataCenter);
    final resp = await _oauthDio.post<Map<String, dynamic>>(
      'https://$domain/oauth/v2/token',
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'client_id': const String.fromEnvironment('ZOHO_CLIENT_ID'),
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final body = resp.data as Map<String, dynamic>;
    final expiresIn = (body['expires_in'] as num?)?.toInt() ?? 3600;
    await tokenStorage.save(
      portalId: account.portalId,
      accessToken: body['access_token'] as String,
      refreshToken: refreshToken,
      expiry: DateTime.now().add(Duration(seconds: expiresIn - 60)),
    );
  }
}
