import 'package:flutter/foundation.dart';

/// What the current customer is allowed to do with tickets in this portal.
///
/// Permissions are per-portal and set in [PortalConfiguration]. The mock
/// enforces these; the live layer derives them from Desk's portal config.
@immutable
class TicketPermissions {
  const TicketPermissions({
    this.canChangeStatus = true,
    this.canChangePriority = true,
    this.canAddComment = true,
    this.canCreateTicket = true,
    this.canCloseTicket = true,
    this.canReopenTicket = true,
    this.canAddAttachment = true,
  });

  final bool canChangeStatus;
  final bool canChangePriority;
  final bool canAddComment;
  final bool canCreateTicket;
  final bool canCloseTicket;
  final bool canReopenTicket;
  final bool canAddAttachment;

  static const TicketPermissions full = TicketPermissions();
  static const TicketPermissions readOnly = TicketPermissions(
    canChangeStatus: false,
    canChangePriority: false,
    canAddComment: false,
    canCreateTicket: false,
    canCloseTicket: false,
    canReopenTicket: false,
    canAddAttachment: false,
  );

  TicketPermissions copyWith({
    bool? canChangeStatus,
    bool? canChangePriority,
    bool? canAddComment,
    bool? canCreateTicket,
    bool? canCloseTicket,
    bool? canReopenTicket,
    bool? canAddAttachment,
  }) {
    return TicketPermissions(
      canChangeStatus: canChangeStatus ?? this.canChangeStatus,
      canChangePriority: canChangePriority ?? this.canChangePriority,
      canAddComment: canAddComment ?? this.canAddComment,
      canCreateTicket: canCreateTicket ?? this.canCreateTicket,
      canCloseTicket: canCloseTicket ?? this.canCloseTicket,
      canReopenTicket: canReopenTicket ?? this.canReopenTicket,
      canAddAttachment: canAddAttachment ?? this.canAddAttachment,
    );
  }
}
