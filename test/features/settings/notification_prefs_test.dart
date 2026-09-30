import 'package:flutter_test/flutter_test.dart';
import 'package:zoho_support_hub/features/settings/domain/notification_prefs.dart';

void main() {
  group('NotificationPrefs', () {
    test('all defaults are true', () {
      const prefs = NotificationPrefs();
      expect(prefs.comments, isTrue);
      expect(prefs.statusChanges, isTrue);
      expect(prefs.ticketUpdates, isTrue);
      expect(prefs.incidentAlerts, isTrue);
      expect(prefs.maintenanceAlerts, isTrue);
    });

    test('copyWith changes only the specified field', () {
      const original = NotificationPrefs();
      final modified = original.copyWith(comments: false);
      expect(modified.comments, isFalse);
      expect(modified.statusChanges, isTrue);
      expect(modified.ticketUpdates, isTrue);
      expect(modified.incidentAlerts, isTrue);
      expect(modified.maintenanceAlerts, isTrue);
    });

    test('copyWith with no arguments returns equivalent object', () {
      const original = NotificationPrefs(
        comments: false,
        incidentAlerts: false,
      );
      final copy = original.copyWith();
      expect(copy.comments, isFalse);
      expect(copy.statusChanges, isTrue);
      expect(copy.incidentAlerts, isFalse);
    });

    test('all fields can be toggled independently', () {
      const prefs = NotificationPrefs();
      expect(prefs.copyWith(comments: false).comments, isFalse);
      expect(prefs.copyWith(statusChanges: false).statusChanges, isFalse);
      expect(prefs.copyWith(ticketUpdates: false).ticketUpdates, isFalse);
      expect(prefs.copyWith(incidentAlerts: false).incidentAlerts, isFalse);
      expect(
        prefs.copyWith(maintenanceAlerts: false).maintenanceAlerts,
        isFalse,
      );
    });
  });
}
