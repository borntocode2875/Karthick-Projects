import 'package:dio/dio.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/http/token_storage.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';

/// Creates a Dio instance pre-configured for Zoho Desk REST API calls.
///
/// Automatically injects the Bearer token and refreshes it on 401.
Dio createZohoDeskDio({
  required DataCenter dataCenter,
  required String portalId,
  required TokenStorage tokenStorage,
  required Future<String> Function(String portalId) refreshAccessToken,
}) {
  final baseUrl = 'https://${dataCenter.apiDomain}/api/v1/';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(
    _AuthInterceptor(
      portalId: portalId,
      tokenStorage: tokenStorage,
      refreshAccessToken: refreshAccessToken,
      dio: dio,
    ),
  );

  dio.interceptors.add(_ErrorInterceptor());

  return dio;
}

// ---------------------------------------------------------------------------
// Auth interceptor
// ---------------------------------------------------------------------------

class _AuthInterceptor extends Interceptor {
  _AuthInterceptor({
    required this.portalId,
    required this.tokenStorage,
    required this.refreshAccessToken,
    required this.dio,
  });

  final String portalId;
  final TokenStorage tokenStorage;
  final Future<String> Function(String portalId) refreshAccessToken;
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final stored = await tokenStorage.load(portalId);
    if (stored != null) {
      final token = stored.expiry.isAfter(DateTime.now())
          ? stored.access
          : await refreshAccessToken(portalId);
      options.headers['Authorization'] = 'Zoho-oauthtoken $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await refreshAccessToken(portalId);
        final opts = err.requestOptions
          ..headers['Authorization'] = 'Zoho-oauthtoken $newToken';
        final response = await dio.fetch<Map<String, dynamic>>(opts);
        handler.resolve(response);
        return;
      } catch (_) {
        handler.reject(err);
        return;
      }
    }
    handler.next(err);
  }
}

// ---------------------------------------------------------------------------
// Error mapping interceptor
// ---------------------------------------------------------------------------

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode;
    if (status == 401) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const UnauthenticatedError('Session expired. Please sign in again.'),
        ),
      );
      return;
    }
    if (status == 403) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const AuthorizationError("This action isn't available."),
        ),
      );
      return;
    }
    if (status == 404) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const NotFoundError('Resource not found.'),
        ),
      );
      return;
    }
    if (status != null && status >= 500) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: ServerError('Server error ($status). Please try again.'),
        ),
      );
      return;
    }
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const NetworkError('No internet connection.'),
        ),
      );
      return;
    }
    handler.next(err);
  }
}
