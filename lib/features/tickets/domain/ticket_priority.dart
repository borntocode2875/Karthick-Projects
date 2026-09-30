/// Urgency level of a support ticket.
enum TicketPriority {
  low,
  medium,
  high,
  urgent;

  String get displayLabel {
    switch (this) {
      case TicketPriority.low:
        return 'Low';
      case TicketPriority.medium:
        return 'Medium';
      case TicketPriority.high:
        return 'High';
      case TicketPriority.urgent:
        return 'Urgent';
    }
  }

  /// Number of filled bars shown in the ticket card (1–4).
  int get barCount {
    switch (this) {
      case TicketPriority.low:
        return 1;
      case TicketPriority.medium:
        return 2;
      case TicketPriority.high:
        return 3;
      case TicketPriority.urgent:
        return 4;
    }
  }
}
