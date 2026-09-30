import 'package:dio/dio.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/http/token_storage.dart';
import 'package:zoho_support_hub/core/http/zoho_dio_client.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_item.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_repository.dart';

class ZohoNotificationRepository implements NotificationRepository {
  ZohoNotificationRepository({required TokenStorage tokenStorage})
      : _tokenStorage = tokenStorage;

  final TokenStorage _tokenStorage;
  final _clients = <String, Dio>{};

  Dio _client(AccountContext ctx) {
    return _clients.putIfAbsent(
      ctx.account.portalId,
      () => createZohoDeskDio(
        dataCenter: ctx.account.dataCenter,
        portalId: ctx.account.portalId,
        tokenStorage: _tokenStorage,
        refreshAccessToken: (portalId) async {
          final s = await _tokenStorage.load(portalId);
          if (s == null) throw const UnauthenticatedError();
          return s.access;
        },
      ),
    );
  }

  @override
  Future<List<NotificationItem>> listNotifications({
    required AccountContext context,
  }) async {
    try {
      final resp = await _client(context).get<Map<String, dynamic>>(
        'portals/${context.account.portalId}/notifications',
        queryParameters: {'limit': 50, 'sortBy': 'createdTime', 'sortOrder': 'desc'},
      );
      final body = resp.data as Map<String, dynamic>;
      return (body['data'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>()
          .map((j) => _fromJson(j, context))
          .toList();
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  @override
  Future<void> markRead({
    required AccountContext context,
    required String notificationId,
  }) async {
    try {
      await _client(context).patch<void>(
        'portals/${context.account.portalId}/notifications/$notificationId',
        data: {'isRead': true},
      );
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  @override
  Future<void> markAllRead({required AccountContext context}) async {
    try {
      await _client(context).patch<void>(
        'portals/${context.account.portalId}/notifications/markAllRead',
      );
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  @override
  Future<void> registerDevice({
    required AccountContext context,
    required String deviceToken,
  }) async {
    try {
      await _client(context).post<void>(
        'portals/${context.account.portalId}/pushTokens',
        data: {'token': deviceToken, 'platform': 'mobile'},
      );
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  @override
  Future<void> unregisterDevice({required AccountContext context}) async {
    try {
      await _client(context).delete<void>(
        'portals/${context.account.portalId}/pushTokens',
      );
    } on DioException catch (e) {
      throw _map(e);
    }
  }

  // ---------------------------------------------------------------------------

  NotificationItem _fromJson(Map<String, dynamic> j, AccountContext ctx) {
    final typeStr = j['notificationType'] as String? ?? '';
    final type = _parseType(typeStr);
    final targetId = j['entityId']?.toString() ?? '';
    final targetType = typeStr.contains('TICKET')
        ? NotificationTargetType.ticket
        : typeStr.contains('INCIDENT') || typeStr.contains('MAINTENANCE')
            ? NotificationTargetType.issue
            : NotificationTargetType.account;

    return NotificationItem(
      id: j['id']?.toString() ?? '',
      type: type,
      accountId: ctx.account.id,
      portalId: ctx.account.portalId,
      dataCenter: ctx.account.dataCenter,
      targetType: targetType,
      targetId: targetId,
      title: j['subject'] as String? ?? '',
      body: j['content'] as String? ?? '',
      receivedAt: _parseDate(j['createdTime'] as String?),
      isRead: j['isRead'] as bool? ?? false,
    );
  }

  static NotificationType _parseType(String s) {
    final l = s.toLowerCase();
    if (l.contains('comment')) return NotificationType.comment;
    if (l.contains('status')) return NotificationType.statusChange;
    if (l.contains('incident')) return NotificationType.incidentAlert;
    if (l.contains('maintenance')) return NotificationType.maintenanceAlert;
    return NotificationType.ticketUpdate;
  }

  static DateTime _parseDate(String? s) {
    if (s == null) return DateTime.now();
    try {
      return DateTime.parse(s);
    } catch (_) {
      return DateTime.now();
    }
  }

  AppError _map(DioException e) {
    if (e.error is AppError) return e.error as AppError;
    return NetworkError(e.message ?? 'Network error.');
  }
}
