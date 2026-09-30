import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

part 'ticket.freezed.dart';

/// A Zoho Desk support ticket as seen by a customer.
@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required String ticketNumber,
    required String subject,
    required String description,
    required TicketStatus status,
    required TicketPriority priority,
    required String accountId,
    required String portalId,
    required DataCenter dataCenter,
    /// The contact ID that owns this ticket.
    required String contactId,
    required String contactName,
    required String contactEmail,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int commentCount,
    @Default(0) int attachmentCount,
    @Default(false) bool hasUnread,
    /// Portal-defined custom field values, keyed by field key.
    @Default({}) Map<String, Object?> customFieldValues,
    String? product,
    String? category,
    String? subCategory,
    DateTime? dueDate,
    DateTime? closedAt,
  }) = _Ticket;
}
