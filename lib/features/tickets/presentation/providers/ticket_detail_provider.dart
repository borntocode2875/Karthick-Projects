import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_comment.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/ticket_list_provider.dart';

// ---------------------------------------------------------------------------
// Data holder
// ---------------------------------------------------------------------------

typedef TicketDetailData = ({Ticket ticket, List<TicketComment> comments});

// ---------------------------------------------------------------------------
// Loader
// ---------------------------------------------------------------------------

final ticketDetailProvider = FutureProvider.autoDispose
    .family<TicketDetailData, String>((ref, ticketId) async {
  final ctx = ref.watch(currentContextProvider);
  if (ctx == null) throw StateError('No active session');

  final repo = ref.read(ticketRepositoryProvider);
  final ticket = await repo.getTicket(context: ctx, ticketId: ticketId);
  final comments = await repo.listComments(context: ctx, ticketId: ticketId);

  return (ticket: ticket, comments: comments.items);
});

// ---------------------------------------------------------------------------
// Mutation notifier — add comment, change status, change priority
// ---------------------------------------------------------------------------

class TicketActionsNotifier extends StateNotifier<AsyncValue<void>> {
  TicketActionsNotifier(this._ref, this._ticketId)
      : super(const AsyncData(null));

  final Ref _ref;
  final String _ticketId;

  Future<bool> addComment(String content) async {
    final ctx = _ref.read(currentContextProvider);
    if (ctx == null) return false;
    state = const AsyncLoading();
    try {
      await _ref.read(ticketRepositoryProvider).addComment(
            context: ctx,
            ticketId: _ticketId,
            content: content,
          );
      _invalidate();
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> updateStatus(TicketStatus status) async {
    final ctx = _ref.read(currentContextProvider);
    if (ctx == null) return false;
    state = const AsyncLoading();
    try {
      await _ref.read(ticketRepositoryProvider).updateTicketStatus(
            context: ctx,
            ticketId: _ticketId,
            status: status,
          );
      _invalidate();
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> updatePriority(TicketPriority priority) async {
    final ctx = _ref.read(currentContextProvider);
    if (ctx == null) return false;
    state = const AsyncLoading();
    try {
      await _ref.read(ticketRepositoryProvider).updateTicketPriority(
            context: ctx,
            ticketId: _ticketId,
            priority: priority,
          );
      _invalidate();
      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  void _invalidate() {
    _ref.invalidate(ticketDetailProvider(_ticketId));
    _ref.invalidate(ticketListProvider);
  }
}

final ticketActionsProvider = StateNotifierProvider.autoDispose
    .family<TicketActionsNotifier, AsyncValue<void>, String>((ref, ticketId) {
  return TicketActionsNotifier(ref, ticketId);
});
