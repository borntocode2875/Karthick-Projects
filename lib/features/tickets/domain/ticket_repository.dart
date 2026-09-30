import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/tickets/domain/create_ticket_input.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_attachment.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_comment.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_filter.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';
import 'package:zoho_support_hub/shared/models/pagination.dart';

abstract class TicketRepository {
  /// Returns a paginated list of tickets the customer owns in this portal.
  ///
  /// The mock enforces that only tickets belonging to [context.contactId]
  /// are returned. Throws [AuthorizationError] if context is invalid.
  Future<PaginatedResult<Ticket>> listTickets({
    required AccountContext context,
    TicketFilter? filter,
    int page = 1,
    int pageSize = 20,
  });

  /// Fetches a single ticket. Throws [AuthorizationError] if the ticket
  /// belongs to a different customer.
  Future<Ticket> getTicket({
    required AccountContext context,
    required String ticketId,
  });

  /// Creates a new ticket. Validates [input] against portal configuration
  /// (required fields, allowed values). Throws [ValidationError] on failure.
  Future<Ticket> createTicket({
    required AccountContext context,
    required CreateTicketInput input,
  });

  /// Changes the ticket status. Validates the transition is allowed by the
  /// portal config and [context.permissions].
  Future<Ticket> updateTicketStatus({
    required AccountContext context,
    required String ticketId,
    required TicketStatus status,
  });

  /// Changes the ticket priority. Validates [context.permissions.canChangePriority].
  Future<Ticket> updateTicketPriority({
    required AccountContext context,
    required String ticketId,
    required TicketPriority priority,
  });

  /// Adds a comment. Validates [context.permissions.canAddComment].
  Future<TicketComment> addComment({
    required AccountContext context,
    required String ticketId,
    required String content,
    List<String> attachmentIds = const [],
  });

  /// Returns paginated comments for a ticket.
  Future<PaginatedResult<TicketComment>> listComments({
    required AccountContext context,
    required String ticketId,
    int page = 1,
    int pageSize = 20,
  });

  /// Returns attachments for a ticket.
  Future<List<TicketAttachment>> listAttachments({
    required AccountContext context,
    required String ticketId,
  });

  /// Uploads a file and returns its attachment ID. Reports progress via
  /// [onProgress] (0.0–1.0). Per-file failure is isolated.
  Future<String> uploadAttachment({
    required AccountContext context,
    required String ticketId,
    required String filePath,
    required String mimeType,
    void Function(double progress)? onProgress,
  });
}
