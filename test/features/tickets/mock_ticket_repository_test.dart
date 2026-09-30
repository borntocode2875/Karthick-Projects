import 'package:flutter_test/flutter_test.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/tickets/data/mock_ticket_repository.dart';
import 'package:zoho_support_hub/features/tickets/domain/create_ticket_input.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

void main() {
  late MockTicketRepository repo;

  setUp(() => repo = MockTicketRepository());

  // ---------------------------------------------------------------------------
  // Cross-tenant isolation
  // ---------------------------------------------------------------------------

  group('cross-tenant isolation', () {
    test('cannot read another contact\'s ticket', () async {
      // mockContextB is a different user (Carol) on portal-b.
      // ticket-a1 belongs to Alice on portal-a.
      expect(
        () => repo.getTicket(context: mockContextB, ticketId: 'ticket-a1'),
        throwsA(isA<NotFoundError>()),
      );
    });

    test('list returns only the caller\'s tickets, not other contacts\'', () async {
      final result = await repo.listTickets(context: mockContextA);
      for (final ticket in result.items) {
        expect(ticket.contactId, equals(mockContextA.contactId));
        expect(ticket.portalId, equals(mockContextA.portalId));
      }
    });

    test('Portal B tickets not visible from Portal A context', () async {
      final result = await repo.listTickets(context: mockContextA);
      expect(
        result.items.every((t) => t.portalId == mockContextA.portalId),
        isTrue,
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Permission enforcement
  // ---------------------------------------------------------------------------

  group('permission enforcement', () {
    test('canChangePriority=false prevents priority update', () async {
      // mockContextB has canChangePriority: false
      const ctxNoPriority = AccountContext(
        user: mockUserAlice,
        account: mockAccountA,
        permissions: TicketPermissions(canChangePriority: false),
      );
      final tickets = await repo.listTickets(context: mockContextA);
      final ticketId = tickets.items.first.id;

      expect(
        () => repo.updateTicketPriority(
          context: ctxNoPriority,
          ticketId: ticketId,
          priority: TicketPriority.urgent,
        ),
        throwsA(isA<AuthorizationError>()),
      );
    });

    test('canChangeStatus=false prevents status update', () async {
      const ctxNoStatus = AccountContext(
        user: mockUserAlice,
        account: mockAccountA,
        permissions: TicketPermissions(canChangeStatus: false),
      );
      final tickets = await repo.listTickets(context: mockContextA);
      final ticketId = tickets.items.first.id;

      expect(
        () => repo.updateTicketStatus(
          context: ctxNoStatus,
          ticketId: ticketId,
          status: TicketStatus.resolved,
        ),
        throwsA(isA<AuthorizationError>()),
      );
    });

    test('canAddComment=false prevents adding a comment', () async {
      const ctxNoComment = AccountContext(
        user: mockUserAlice,
        account: mockAccountA,
        permissions: TicketPermissions(canAddComment: false),
      );
      final tickets = await repo.listTickets(context: mockContextA);
      final ticketId = tickets.items.first.id;

      expect(
        () => repo.addComment(
          context: ctxNoComment,
          ticketId: ticketId,
          content: 'hello',
        ),
        throwsA(isA<AuthorizationError>()),
      );
    });

    test('canCreateTicket=false prevents ticket creation', () async {
      const ctxNoCreate = AccountContext(
        user: mockUserAlice,
        account: mockAccountA,
        permissions: TicketPermissions(canCreateTicket: false),
      );
      expect(
        () => repo.createTicket(
          context: ctxNoCreate,
          input: const CreateTicketInput(
            subject: 'Test',
            description: 'Test description',
            priority: TicketPriority.medium,
          ),
        ),
        throwsA(isA<AuthorizationError>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Validation
  // ---------------------------------------------------------------------------

  group('validation', () {
    test('createTicket rejects empty subject', () async {
      expect(
        () => repo.createTicket(
          context: mockContextA,
          input: const CreateTicketInput(
            subject: '   ',
            description: 'Some description',
            priority: TicketPriority.medium,
          ),
        ),
        throwsA(isA<ValidationError>()),
      );
    });

    test('createTicket rejects empty description', () async {
      expect(
        () => repo.createTicket(
          context: mockContextA,
          input: const CreateTicketInput(
            subject: 'Valid subject',
            description: '',
            priority: TicketPriority.medium,
          ),
        ),
        throwsA(isA<ValidationError>()),
      );
    });

    test('addComment rejects blank content', () async {
      final tickets = await repo.listTickets(context: mockContextA);
      expect(
        () => repo.addComment(
          context: mockContextA,
          ticketId: tickets.items.first.id,
          content: '   ',
        ),
        throwsA(isA<ValidationError>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Mutation round-trips
  // ---------------------------------------------------------------------------

  group('mutation round-trips', () {
    test('updateTicketStatus persists the new status', () async {
      final tickets = await repo.listTickets(context: mockContextA);
      final target = tickets.items.first;

      await repo.updateTicketStatus(
        context: mockContextA,
        ticketId: target.id,
        status: TicketStatus.resolved,
      );

      final refreshed = await repo.getTicket(
        context: mockContextA,
        ticketId: target.id,
      );
      expect(refreshed.status, equals(TicketStatus.resolved));
    });

    test('updateTicketPriority persists the new priority', () async {
      final tickets = await repo.listTickets(context: mockContextA);
      final target = tickets.items.first;

      await repo.updateTicketPriority(
        context: mockContextA,
        ticketId: target.id,
        priority: TicketPriority.low,
      );

      final refreshed = await repo.getTicket(
        context: mockContextA,
        ticketId: target.id,
      );
      expect(refreshed.priority, equals(TicketPriority.low));
    });

    test('createTicket appears in subsequent list', () async {
      await repo.createTicket(
        context: mockContextA,
        input: const CreateTicketInput(
          subject: 'Brand new ticket',
          description: 'Some description here.',
          priority: TicketPriority.medium,
        ),
      );

      final result = await repo.listTickets(context: mockContextA);
      expect(
        result.items.any((t) => t.subject == 'Brand new ticket'),
        isTrue,
      );
    });
  });
}
