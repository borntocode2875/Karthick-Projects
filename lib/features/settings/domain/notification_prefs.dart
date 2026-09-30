import 'package:flutter/foundation.dart';

@immutable
class NotificationPrefs {
  const NotificationPrefs({
    this.comments = true,
    this.statusChanges = true,
    this.ticketUpdates = true,
    this.incidentAlerts = true,
    this.maintenanceAlerts = true,
  });

  final bool comments;
  final bool statusChanges;
  final bool ticketUpdates;
  final bool incidentAlerts;
  final bool maintenanceAlerts;

  NotificationPrefs copyWith({
    bool? comments,
    bool? statusChanges,
    bool? ticketUpdates,
    bool? incidentAlerts,
    bool? maintenanceAlerts,
  }) =>
      NotificationPrefs(
        comments: comments ?? this.comments,
        statusChanges: statusChanges ?? this.statusChanges,
        ticketUpdates: ticketUpdates ?? this.ticketUpdates,
        incidentAlerts: incidentAlerts ?? this.incidentAlerts,
        maintenanceAlerts: maintenanceAlerts ?? this.maintenanceAlerts,
      );
}
