import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/tickets/domain/create_ticket_input.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

part 'zia_action.freezed.dart';

/// The type of action Zia is proposing.
enum ZiaActionType { createTicket, addComment, changeStatus, changePriority }

/// A pending action proposed by Zia that the user must confirm before execution.
///
/// Nothing executes until the user confirms; after confirmation the action
/// runs through the appropriate repository method with full authorization checks.
@freezed
abstract class ZiaAction with _$ZiaAction {
  const factory ZiaAction({
    required String id,
    required ZiaActionType type,
    required String confirmLabel,
    /// Target ticket ID (null for createTicket actions).
    String? ticketId,
    String? ticketSubject,
    /// For changeStatus: the current status.
    TicketStatus? fromStatus,
    /// For changeStatus: the proposed status.
    TicketStatus? toStatus,
    /// For changePriority: the current priority.
    TicketPriority? fromPriority,
    /// For changePriority: the proposed priority.
    TicketPriority? toPriority,
    /// For addComment: the comment text.
    String? commentContent,
    /// For createTicket: the prefilled input.
    CreateTicketInput? createInput,
    @Default(false) bool isConfirmed,
    @Default(false) bool isRejected,
  }) = _ZiaAction;
}
