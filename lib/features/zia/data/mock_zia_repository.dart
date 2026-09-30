import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/utils/mock_latency.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_action.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_chat_message.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_repository.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_response.dart';

/// Deterministic Zia using intent matching — no LLM.
///
/// Matches user messages by keyword patterns and returns scripted responses.
/// Prompt-injection attempts are rejected at this layer (security rule 4).
class MockZiaRepository implements ZiaRepository {
  static const _injectionPatterns = [
    'ignore previous',
    'act as admin',
    'as an agent',
    'disregard',
    'forget instructions',
    'system prompt',
    'override',
    'jailbreak',
  ];

  bool _isInjectionAttempt(String msg) {
    final lower = msg.toLowerCase();
    return _injectionPatterns.any(lower.contains);
  }

  bool _matches(String msg, List<String> keywords) {
    final lower = msg.toLowerCase();
    return keywords.any(lower.contains);
  }

  @override
  Future<ZiaResponse> sendMessage({
    required AccountContext context,
    required String message,
    required List<ZiaChatMessage> history,
  }) async {
    await mockDelay();

    // Security: reject prompt-injection attempts.
    if (_isInjectionAttempt(message)) {
      throw const AuthorizationError(
        "I can only help with your support tickets and Zoho service status.",
      );
    }

    final msg = message.toLowerCase();
    final id = 'zia-${DateTime.now().millisecondsSinceEpoch}';

    // --- Ticket lookup ---
    if (_matches(msg, ['status', 'ticket', 'open ticket', 'my ticket'])) {
      final ticketNum = RegExp(r'\b\d{4,6}\b').firstMatch(msg)?.group(0);
      if (ticketNum != null) {
        final tickets = mockTicketsByPortal[context.portalId] ?? [];
        final match = tickets
            .where((t) =>
                t.ticketNumber == ticketNum &&
                t.contactId == context.contactId)
            .firstOrNull;
        if (match != null) {
          return ZiaResponse(
            messageId: id,
            text: 'Ticket #${match.ticketNumber} — "${match.subject}" is currently '
                '**${match.status.displayLabel}** with **${match.priority.displayLabel}** priority. '
                'Last updated ${_timeAgo(match.updatedAt)}.',
            referencedTicketIds: [match.id],
          );
        } else {
          return ZiaResponse(
            messageId: id,
            text: "I couldn't find ticket #$ticketNum in your account. "
                "Please check the number and try again.",
          );
        }
      }

      // List open tickets
      final open = (mockTicketsByPortal[context.portalId] ?? [])
          .where((t) =>
              t.contactId == context.contactId && !t.status.isResolved)
          .toList();
      if (open.isEmpty) {
        return ZiaResponse(
          messageId: id,
          text: "You have no open tickets in ${context.account.portalName} right now. "
              "Would you like to create one?",
        );
      }
      final summary = open
          .take(3)
          .map((t) => '• #${t.ticketNumber} — ${t.subject} (${t.status.displayLabel})')
          .join('\n');
      return ZiaResponse(
        messageId: id,
        text: "You have ${open.length} open ticket(s):\n$summary",
        referencedTicketIds: open.take(3).map((t) => t.id).toList(),
      );
    }

    // --- Ongoing issue / service status check ---
    if (_matches(msg, ['crm', 'books', 'analytics', 'creator', 'desk', 'down', 'slow',
        'not working', 'outage', 'issue', 'status', 'service'])) {
      final productKeywords = {
        'crm': 'Zoho CRM',
        'books': 'Zoho Books',
        'analytics': 'Zoho Analytics',
        'creator': 'Zoho Creator',
        'desk': 'Zoho Desk',
      };

      String? matchedProduct;
      for (final entry in productKeywords.entries) {
        if (msg.contains(entry.key)) {
          matchedProduct = entry.value;
          break;
        }
      }

      final relatedIssues = mockOngoingIssues
          .where((i) =>
              i.isActive &&
              (matchedProduct == null ||
                  i.affectedProducts
                      .any((p) => p.toLowerCase() == matchedProduct!.toLowerCase())) &&
              i.affectedDataCenters.contains(context.dataCenter))
          .toList();

      if (relatedIssues.isEmpty) {
        final text = matchedProduct != null
            ? "There are no known active incidents for $matchedProduct in your region. "
              "If you're experiencing issues, I can help you create a support ticket."
            : "There are no active incidents in your region right now. "
              "Would you like to create a ticket about what you're experiencing?";
        return ZiaResponse(messageId: id, text: text);
      }

      if (relatedIssues.length == 1) {
        final issue = relatedIssues.first;
        return ZiaResponse(
          messageId: id,
          text: "There is an active incident that may be related to what you're experiencing:\n\n"
              "**${issue.title}** — ${issue.description}\n\n"
              "Our engineers are working on a fix. You can still create a ticket if you'd like.",
          referencedIssueIds: [issue.id],
        );
      }

      final summary = relatedIssues
          .take(3)
          .map((i) => '• ${i.title}')
          .join('\n');
      return ZiaResponse(
        messageId: id,
        text: "There are ${relatedIssues.length} active incidents that may be related:\n$summary\n\n"
            "You can still raise a ticket if needed.",
        referencedIssueIds: relatedIssues.take(3).map((i) => i.id).toList(),
      );
    }

    // --- Action: change status ---
    if (_matches(msg, ['close ticket', 'resolve ticket', 'mark as resolved', 'mark resolved'])) {
      final ticketNum = RegExp(r'\b\d{4,6}\b').firstMatch(msg)?.group(0);
      if (ticketNum != null) {
        final tickets = mockTicketsByPortal[context.portalId] ?? [];
        final match = tickets
            .where((t) =>
                t.ticketNumber == ticketNum &&
                t.contactId == context.contactId)
            .firstOrNull;
        if (match != null && context.permissions.canChangeStatus) {
          final action = ZiaAction(
            id: 'action-${DateTime.now().millisecondsSinceEpoch}',
            type: ZiaActionType.changeStatus,
            confirmLabel: 'Mark Resolved',
            ticketId: match.id,
            ticketSubject: match.subject,
            fromStatus: match.status,
            toStatus: TicketStatus.resolved,
          );
          return ZiaResponse(
            messageId: id,
            text: "I can mark ticket #${match.ticketNumber} — \"${match.subject}\" as Resolved. "
                "Shall I go ahead?",
            proposedAction: action,
            referencedTicketIds: [match.id],
          );
        }
      }
    }

    // --- Action: change priority ---
    if (_matches(msg, ['change priority', 'set priority', 'make it urgent', 'high priority'])) {
      if (!context.permissions.canChangePriority) {
        return ZiaResponse(
          messageId: id,
          text: "Priority changes aren't available in this portal. "
              "Please contact support if you feel the urgency needs to be escalated.",
        );
      }
      TicketPriority? newPriority;
      if (msg.contains('urgent')) newPriority = TicketPriority.urgent;
      if (msg.contains('high')) newPriority = TicketPriority.high;
      if (msg.contains('medium')) newPriority = TicketPriority.medium;
      if (msg.contains('low')) newPriority = TicketPriority.low;

      final ticketNum = RegExp(r'\b\d{4,6}\b').firstMatch(msg)?.group(0);
      if (ticketNum != null && newPriority != null) {
        final tickets = mockTicketsByPortal[context.portalId] ?? [];
        final match = tickets
            .where((t) =>
                t.ticketNumber == ticketNum &&
                t.contactId == context.contactId)
            .firstOrNull;
        if (match != null) {
          final action = ZiaAction(
            id: 'action-${DateTime.now().millisecondsSinceEpoch}',
            type: ZiaActionType.changePriority,
            confirmLabel: 'Change to ${newPriority.displayLabel}',
            ticketId: match.id,
            ticketSubject: match.subject,
            fromPriority: match.priority,
            toPriority: newPriority,
          );
          return ZiaResponse(
            messageId: id,
            text: 'I can change the priority of ticket #${match.ticketNumber} '
                'from ${match.priority.displayLabel} to ${newPriority.displayLabel}. '
                'Shall I proceed?',
            proposedAction: action,
            referencedTicketIds: [match.id],
          );
        }
      }
    }

    // --- Admin/out-of-scope rejection ---
    if (_matches(msg, ['agent', 'assign', 'reassign', 'department', 'sla', 'report',
        'dashboard', 'admin', 'configure', 'automation'])) {
      return ZiaResponse(
        messageId: id,
        text: "I can help you with your own tickets and Zoho service status. "
            "For admin tasks, please contact your portal administrator.",
      );
    }

    // --- Fallback ---
    return ZiaResponse(
      messageId: id,
      text: "I can help you check your ticket status, look up Zoho service incidents, "
          "or create a new ticket. What would you like to do?",
    );
  }

  @override
  Future<ZiaAction> confirmAction({
    required AccountContext context,
    required ZiaAction action,
  }) async {
    await mockDelay();
    if (action.isRejected) throw const AuthorizationError();
    return action.copyWith(isConfirmed: true);
  }

  @override
  Future<ZiaAction> rejectAction({
    required AccountContext context,
    required ZiaAction action,
  }) async {
    await mockShortDelay();
    return action.copyWith(isRejected: true);
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    return '${diff.inMinutes}m ago';
  }
}
