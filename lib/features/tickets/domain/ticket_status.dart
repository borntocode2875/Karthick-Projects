/// Lifecycle status of a support ticket.
///
/// The available subset is driven by [PortalConfiguration.availableStatuses];
/// this enum covers all statuses Zoho Desk can surface.
enum TicketStatus {
  open,
  inProgress,
  onHold,
  escalated,
  resolved,
  closed;

  String get displayLabel {
    switch (this) {
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.inProgress:
        return 'In Progress';
      case TicketStatus.onHold:
        return 'On Hold';
      case TicketStatus.escalated:
        return 'Escalated';
      case TicketStatus.resolved:
        return 'Resolved';
      case TicketStatus.closed:
        return 'Closed';
    }
  }

  bool get isTerminal => this == TicketStatus.closed;
  bool get isResolved => this == TicketStatus.resolved || isTerminal;
}
