import 'package:dio/dio.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/http/token_storage.dart';
import 'package:zoho_support_hub/core/http/zoho_dio_client.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/tickets/domain/create_ticket_input.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_attachment.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_comment.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_filter.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_repository.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';
import 'package:zoho_support_hub/shared/models/pagination.dart';

class ZohoTicketRepository implements TicketRepository {
  ZohoTicketRepository({required TokenStorage tokenStorage})
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
          final stored = await _tokenStorage.load(portalId);
          if (stored == null) throw const UnauthenticatedError();
          // Re-use the refresh token — actual token refresh happens in the interceptor.
          return stored.access;
        },
      ),
    );
  }

  @override
  Future<PaginatedResult<Ticket>> listTickets({
    required AccountContext context,
    TicketFilter? filter,
    int page = 1,
    int pageSize = 20,
  }) async {
    _checkAuth(context);
    try {
      final params = <String, dynamic>{
        'from': (page - 1) * pageSize,
        'limit': pageSize,
        'sortBy': _sortParam(filter?.sortField),
        'sortOrder': filter?.sortDirection == SortDirection.asc ? 'asc' : 'desc',
        'contactId': context.contactId,
      };
      if (filter?.searchQuery?.isNotEmpty == true) {
        params['subject'] = filter!.searchQuery!;
      }
      if (filter?.statuses.isNotEmpty == true) {
        params['status'] = filter!.statuses.map(_statusToApi).join(',');
      }
      if (filter?.priorities.isNotEmpty == true) {
        params['priority'] = filter!.priorities.map(_priorityToApi).join(',');
      }

      final resp = await _client(context).get<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets',
        queryParameters: params,
      );
      final body = resp.data as Map<String, dynamic>;
      final list = (body['data'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>()
          .map((j) => _ticketFromJson(j, context))
          .toList();
      final total = (body['count'] as num?)?.toInt() ?? list.length;
      return PaginatedResult(items: list, totalCount: total, page: page, pageSize: pageSize);
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<Ticket> getTicket({
    required AccountContext context,
    required String ticketId,
  }) async {
    _checkAuth(context);
    try {
      final resp = await _client(context).get<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets/$ticketId',
      );
      final ticket = _ticketFromJson(resp.data as Map<String, dynamic>, context);
      if (ticket.contactId != context.contactId) {
        throw const NotFoundError();
      }
      return ticket;
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<Ticket> createTicket({
    required AccountContext context,
    required CreateTicketInput input,
  }) async {
    _checkAuth(context);
    if (!context.permissions.canCreateTicket) {
      throw const AuthorizationError();
    }
    if (input.subject.trim().isEmpty) {
      throw const ValidationError('Subject is required.');
    }
    if (input.description.trim().isEmpty) {
      throw const ValidationError('Description is required.');
    }
    try {
      final body = <String, dynamic>{
        'subject': input.subject.trim(),
        'description': input.description.trim(),
        'priority': _priorityToApi(input.priority),
        if (input.product != null) 'product': {'name': input.product},
        if (input.category != null) 'category': input.category,
        'contactId': context.contactId,
        ...input.customFieldValues,
      };
      final resp = await _client(context).post<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets',
        data: body,
      );
      return _ticketFromJson(resp.data as Map<String, dynamic>, context);
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<Ticket> updateTicketStatus({
    required AccountContext context,
    required String ticketId,
    required TicketStatus status,
  }) async {
    _checkAuth(context);
    if (!context.permissions.canChangeStatus) {
      throw const AuthorizationError();
    }
    try {
      final resp = await _client(context).patch<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets/$ticketId',
        data: {'status': _statusToApi(status)},
      );
      return _ticketFromJson(resp.data as Map<String, dynamic>, context);
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<Ticket> updateTicketPriority({
    required AccountContext context,
    required String ticketId,
    required TicketPriority priority,
  }) async {
    _checkAuth(context);
    if (!context.permissions.canChangePriority) {
      throw const AuthorizationError();
    }
    try {
      final resp = await _client(context).patch<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets/$ticketId',
        data: {'priority': _priorityToApi(priority)},
      );
      return _ticketFromJson(resp.data as Map<String, dynamic>, context);
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<TicketComment> addComment({
    required AccountContext context,
    required String ticketId,
    required String content,
    List<String> attachmentIds = const [],
  }) async {
    _checkAuth(context);
    if (!context.permissions.canAddComment) {
      throw const AuthorizationError();
    }
    if (content.trim().isEmpty) {
      throw const ValidationError('Comment cannot be empty.');
    }
    try {
      final resp = await _client(context).post<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets/$ticketId/comments',
        data: {
          'content': content.trim(),
          'isPublic': true,
          if (attachmentIds.isNotEmpty) 'attachments': attachmentIds,
        },
      );
      return _commentFromJson(resp.data as Map<String, dynamic>, ticketId);
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<PaginatedResult<TicketComment>> listComments({
    required AccountContext context,
    required String ticketId,
    int page = 1,
    int pageSize = 20,
  }) async {
    _checkAuth(context);
    try {
      final resp = await _client(context).get<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets/$ticketId/comments',
        queryParameters: {'from': (page - 1) * pageSize, 'limit': pageSize},
      );
      final body = resp.data as Map<String, dynamic>;
      final list = (body['data'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>()
          .map((j) => _commentFromJson(j, ticketId))
          .toList();
      return PaginatedResult(
        items: list,
        totalCount: (body['count'] as num?)?.toInt() ?? list.length,
        page: page,
        pageSize: pageSize,
      );
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<List<TicketAttachment>> listAttachments({
    required AccountContext context,
    required String ticketId,
  }) async {
    _checkAuth(context);
    try {
      final resp = await _client(context).get<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets/$ticketId/attachments',
      );
      final body = resp.data as Map<String, dynamic>;
      return (body['data'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>()
          .map(_attachmentFromJson)
          .toList();
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  @override
  Future<String> uploadAttachment({
    required AccountContext context,
    required String ticketId,
    required String filePath,
    required String mimeType,
    void Function(double progress)? onProgress,
  }) async {
    _checkAuth(context);
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, contentType: DioMediaType.parse(mimeType)),
      });
      final resp = await _client(context).post<Map<String, dynamic>>(
        'portals/${context.account.portalId}/tickets/$ticketId/attachments',
        data: formData,
        onSendProgress: (sent, total) {
          if (total > 0) onProgress?.call(sent / total);
        },
      );
      final body = resp.data as Map<String, dynamic>;
      return body['id']?.toString() ?? '';
    } on DioException catch (e) {
      throw _mapDio(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Mapping helpers
  // ---------------------------------------------------------------------------

  void _checkAuth(AccountContext ctx) {
    if (ctx.user.id.isEmpty) throw const UnauthenticatedError();
  }

  AppError _mapDio(DioException e) {
    if (e.error is AppError) return e.error as AppError;
    return NetworkError(e.message ?? 'Network error.');
  }

  Ticket _ticketFromJson(Map<String, dynamic> j, AccountContext ctx) {
    return Ticket(
      id: j['id']?.toString() ?? '',
      ticketNumber: j['ticketNumber']?.toString() ?? '',
      subject: j['subject'] as String? ?? '',
      description: j['description'] as String? ?? '',
      status: _statusFromApi(j['status'] as String? ?? ''),
      priority: _priorityFromApi(j['priority'] as String? ?? ''),
      accountId: ctx.account.id,
      portalId: ctx.account.portalId,
      dataCenter: ctx.account.dataCenter,
      contactId: j['contactId']?.toString() ?? ctx.contactId,
      contactName: (j['contact'] as Map<dynamic, dynamic>?)?['lastName'] as String? ?? '',
      contactEmail: (j['contact'] as Map<dynamic, dynamic>?)?['email'] as String? ?? ctx.user.email,
      createdAt: _parseDate(j['createdTime'] as String?),
      updatedAt: _parseDate(j['modifiedTime'] as String?),
      commentCount: (j['commentsCount'] as num?)?.toInt() ?? 0,
      attachmentCount: (j['attachmentCount'] as num?)?.toInt() ?? 0,
      hasUnread: j['isUnread'] as bool? ?? false,
      product: (j['product'] as Map<dynamic, dynamic>?)?['name'] as String?,
      category: j['category'] as String?,
    );
  }

  TicketComment _commentFromJson(Map<String, dynamic> j, String ticketId) {
    return TicketComment(
      id: j['id']?.toString() ?? '',
      ticketId: ticketId,
      content: j['content'] as String? ?? '',
      authorName: (j['author'] as Map<dynamic, dynamic>?)?['name'] as String? ?? '',
      authorType: (j['author'] as Map<dynamic, dynamic>?)?['type'] == 'AGENT'
          ? CommentAuthorType.agent
          : CommentAuthorType.customer,
      createdAt: _parseDate(j['createdTime'] as String?),
      isPublic: j['isPublic'] as bool? ?? true,
    );
  }

  TicketAttachment _attachmentFromJson(Map<String, dynamic> j) {
    return TicketAttachment(
      id: j['id']?.toString() ?? '',
      name: j['fileName'] as String? ?? '',
      mimeType: j['contentType'] as String? ?? 'application/octet-stream',
      sizeBytes: (j['size'] as num?)?.toInt() ?? 0,
      downloadUrl: j['href'] as String? ?? '',
      uploadedAt: _parseDate(j['createdTime'] as String?),
    );
  }

  static DateTime _parseDate(String? s) {
    if (s == null) return DateTime.now();
    try {
      return DateTime.parse(s);
    } catch (_) {
      return DateTime.now();
    }
  }

  static String _statusToApi(TicketStatus s) => switch (s) {
        TicketStatus.open => 'Open',
        TicketStatus.inProgress => 'In Progress',
        TicketStatus.onHold => 'On Hold',
        TicketStatus.escalated => 'Escalated',
        TicketStatus.resolved => 'Resolved',
        TicketStatus.closed => 'Closed',
      };

  static TicketStatus _statusFromApi(String s) => switch (s.toLowerCase()) {
        'in progress' => TicketStatus.inProgress,
        'on hold' => TicketStatus.onHold,
        'escalated' => TicketStatus.escalated,
        'resolved' => TicketStatus.resolved,
        'closed' => TicketStatus.closed,
        _ => TicketStatus.open,
      };

  static String _priorityToApi(TicketPriority p) => switch (p) {
        TicketPriority.low => 'Low',
        TicketPriority.medium => 'Medium',
        TicketPriority.high => 'High',
        TicketPriority.urgent => 'Urgent',
      };

  static TicketPriority _priorityFromApi(String p) => switch (p.toLowerCase()) {
        'high' => TicketPriority.high,
        'urgent' => TicketPriority.urgent,
        'low' => TicketPriority.low,
        _ => TicketPriority.medium,
      };

  static String _sortParam(TicketSortField? f) => switch (f) {
        TicketSortField.createdAt => 'createdTime',
        TicketSortField.priority => 'priority',
        TicketSortField.status => 'status',
        _ => 'modifiedTime',
      };
}
