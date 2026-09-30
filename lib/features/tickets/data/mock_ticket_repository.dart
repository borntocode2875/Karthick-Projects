import 'dart:math';

import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/utils/mock_latency.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
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

class MockTicketRepository implements TicketRepository {
  // Mutable in-memory state seeded from mock_data.dart.
  final Map<String, List<Ticket>> _tickets = {
    for (final e in mockTicketsByPortal.entries)
      e.key: List.of(e.value),
  };
  final Map<String, List<TicketComment>> _comments = {};
  final Map<String, List<TicketAttachment>> _attachments = {};
  int _nextTicketNum = 50000;

  // ---------------------------------------------------------------------------
  // Authorization helpers
  // ---------------------------------------------------------------------------

  void _assertOwnership(AccountContext ctx, Ticket ticket) {
    if (ticket.contactId != ctx.contactId) {
      throw const AuthorizationError();
    }
    if (ticket.accountId != ctx.accountId ||
        ticket.portalId != ctx.portalId ||
        ticket.dataCenter != ctx.dataCenter) {
      throw const AuthorizationError();
    }
  }

  List<Ticket> _portalTickets(AccountContext ctx) =>
      _tickets[ctx.portalId] ?? [];

  Ticket _findTicket(AccountContext ctx, String ticketId) {
    final all = _tickets[ctx.portalId] ?? [];
    final idx = all.indexWhere((t) => t.id == ticketId);
    if (idx == -1) throw const NotFoundError();
    final ticket = all[idx];
    _assertOwnership(ctx, ticket);
    return ticket;
  }

  // ---------------------------------------------------------------------------
  // List
  // ---------------------------------------------------------------------------

  @override
  Future<PaginatedResult<Ticket>> listTickets({
    required AccountContext context,
    TicketFilter? filter,
    int page = 1,
    int pageSize = 20,
  }) async {
    await mockDelay();
    final f = filter ?? const TicketFilter();

    var items = _portalTickets(context)
        .where((t) => t.contactId == context.contactId)
        .toList();

    if (f.statuses.isNotEmpty) {
      items = items.where((t) => f.statuses.contains(t.status)).toList();
    }
    if (f.priorities.isNotEmpty) {
      items = items.where((t) => f.priorities.contains(t.priority)).toList();
    }
    if (f.product != null) {
      items = items.where((t) => t.product == f.product).toList();
    }
    if (f.category != null) {
      items = items.where((t) => t.category == f.category).toList();
    }
    if (f.searchQuery != null && f.searchQuery!.isNotEmpty) {
      final q = f.searchQuery!.toLowerCase();
      items = items
          .where((t) =>
              t.subject.toLowerCase().contains(q) ||
              t.ticketNumber.contains(q))
          .toList();
    }

    items.sort((a, b) {
      int cmp;
      switch (f.sortField) {
        case TicketSortField.createdAt:
          cmp = a.createdAt.compareTo(b.createdAt);
        case TicketSortField.priority:
          cmp = a.priority.index.compareTo(b.priority.index);
        case TicketSortField.status:
          cmp = a.status.index.compareTo(b.status.index);
        case TicketSortField.updatedAt:
          cmp = a.updatedAt.compareTo(b.updatedAt);
      }
      return f.sortDirection == SortDirection.desc ? -cmp : cmp;
    });

    final total = items.length;
    final start = (page - 1) * pageSize;
    final end = min(start + pageSize, total);
    final page_ = start >= total ? <Ticket>[] : items.sublist(start, end);

    return PaginatedResult(
      items: page_,
      totalCount: total,
      page: page,
      pageSize: pageSize,
    );
  }

  // ---------------------------------------------------------------------------
  // Get single
  // ---------------------------------------------------------------------------

  @override
  Future<Ticket> getTicket({
    required AccountContext context,
    required String ticketId,
  }) async {
    await mockDelay();
    return _findTicket(context, ticketId);
  }

  // ---------------------------------------------------------------------------
  // Create
  // ---------------------------------------------------------------------------

  @override
  Future<Ticket> createTicket({
    required AccountContext context,
    required CreateTicketInput input,
  }) async {
    await mockDelay();
    if (!context.permissions.canCreateTicket) throw const AuthorizationError();
    if (input.subject.trim().isEmpty) {
      throw const ValidationError('Subject is required.');
    }
    if (input.description.trim().isEmpty) {
      throw const ValidationError('Description is required.');
    }

    final ticket = Ticket(
      id: 'ticket-new-${DateTime.now().millisecondsSinceEpoch}',
      ticketNumber: '${++_nextTicketNum}',
      subject: input.subject,
      description: input.description,
      status: TicketStatus.open,
      priority: input.priority,
      accountId: context.accountId,
      portalId: context.portalId,
      dataCenter: context.dataCenter,
      contactId: context.contactId,
      contactName: context.user.name,
      contactEmail: context.user.email,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      customFieldValues: input.customFieldValues,
      product: input.product,
      category: input.category,
      subCategory: input.subCategory,
    );

    _tickets.putIfAbsent(context.portalId, () => []).add(ticket);
    return ticket;
  }

  // ---------------------------------------------------------------------------
  // Update status
  // ---------------------------------------------------------------------------

  @override
  Future<Ticket> updateTicketStatus({
    required AccountContext context,
    required String ticketId,
    required TicketStatus status,
  }) async {
    await mockDelay();
    if (!context.permissions.canChangeStatus) throw const AuthorizationError();
    final ticket = _findTicket(context, ticketId);
    final updated = ticket.copyWith(status: status, updatedAt: DateTime.now());
    _replaceTicket(context.portalId, updated);
    return updated;
  }

  // ---------------------------------------------------------------------------
  // Update priority
  // ---------------------------------------------------------------------------

  @override
  Future<Ticket> updateTicketPriority({
    required AccountContext context,
    required String ticketId,
    required TicketPriority priority,
  }) async {
    await mockDelay();
    if (!context.permissions.canChangePriority) throw const AuthorizationError();
    final ticket = _findTicket(context, ticketId);
    final updated = ticket.copyWith(priority: priority, updatedAt: DateTime.now());
    _replaceTicket(context.portalId, updated);
    return updated;
  }

  // ---------------------------------------------------------------------------
  // Comments
  // ---------------------------------------------------------------------------

  @override
  Future<TicketComment> addComment({
    required AccountContext context,
    required String ticketId,
    required String content,
    List<String> attachmentIds = const [],
  }) async {
    await mockDelay();
    if (!context.permissions.canAddComment) throw const AuthorizationError();
    _findTicket(context, ticketId); // ownership check
    if (content.trim().isEmpty) {
      throw const ValidationError('Comment content is required.');
    }

    final comment = TicketComment(
      id: 'cmt-${DateTime.now().millisecondsSinceEpoch}',
      ticketId: ticketId,
      content: content,
      authorName: context.user.name,
      authorType: CommentAuthorType.customer,
      createdAt: DateTime.now(),
      attachmentIds: attachmentIds,
      isPublic: true,
    );
    _comments.putIfAbsent(ticketId, () => []).add(comment);
    return comment;
  }

  @override
  Future<PaginatedResult<TicketComment>> listComments({
    required AccountContext context,
    required String ticketId,
    int page = 1,
    int pageSize = 20,
  }) async {
    await mockDelay();
    _findTicket(context, ticketId); // ownership check
    final all = _comments[ticketId] ?? _defaultComments(ticketId);
    return PaginatedResult(
      items: all.skip((page - 1) * pageSize).take(pageSize).toList(),
      totalCount: all.length,
      page: page,
      pageSize: pageSize,
    );
  }

  List<TicketComment> _defaultComments(String ticketId) {
    if (ticketId == 'ticket-a1') {
      return [
        TicketComment(
          id: 'cmt-a1-1',
          ticketId: ticketId,
          content: 'Thank you for contacting Northwind Support. We are looking into this sync issue.',
          authorName: 'Northwind Support',
          authorType: CommentAuthorType.agent,
          createdAt: DateTime(2024, 11, 2, 9, 30),
          isPublic: true,
        ),
        TicketComment(
          id: 'cmt-a1-2',
          ticketId: ticketId,
          content: 'The issue started after the CRM update on 28-Oct. All contacts in the "South" region are affected.',
          authorName: 'Alice Johnson',
          authorType: CommentAuthorType.customer,
          createdAt: DateTime(2024, 11, 2, 10, 15),
          isPublic: true,
        ),
      ];
    }
    return [];
  }

  // ---------------------------------------------------------------------------
  // Attachments
  // ---------------------------------------------------------------------------

  @override
  Future<List<TicketAttachment>> listAttachments({
    required AccountContext context,
    required String ticketId,
  }) async {
    await mockDelay();
    _findTicket(context, ticketId); // ownership check
    return _attachments[ticketId] ?? [];
  }

  @override
  Future<String> uploadAttachment({
    required AccountContext context,
    required String ticketId,
    required String filePath,
    required String mimeType,
    void Function(double progress)? onProgress,
  }) async {
    _findTicket(context, ticketId); // ownership check
    // Simulate upload progress in chunks.
    for (var i = 1; i <= 5; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      onProgress?.call(i / 5);
    }
    final attachmentId = 'att-${DateTime.now().millisecondsSinceEpoch}';
    final name = filePath.split('/').last;
    _attachments.putIfAbsent(ticketId, () => []).add(TicketAttachment(
      id: attachmentId,
      name: name,
      mimeType: mimeType,
      sizeBytes: 256 * 1024, // mock 256 KB
      downloadUrl: 'https://mock/$attachmentId',
      uploadedAt: DateTime.now(),
    ));
    return attachmentId;
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _replaceTicket(String portalId, Ticket updated) {
    final list = _tickets[portalId];
    if (list == null) return;
    final idx = list.indexWhere((t) => t.id == updated.id);
    if (idx != -1) list[idx] = updated;
  }
}
