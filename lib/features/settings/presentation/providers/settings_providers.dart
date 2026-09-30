import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/settings/domain/notification_prefs.dart';

// ---------------------------------------------------------------------------
// Notification preferences
// ---------------------------------------------------------------------------

class NotificationPrefsNotifier extends StateNotifier<NotificationPrefs> {
  NotificationPrefsNotifier(this._prefs) : super(_load(_prefs));

  final SharedPreferences _prefs;

  static const _kComments = 'notif_comments';
  static const _kStatusChanges = 'notif_status_changes';
  static const _kTicketUpdates = 'notif_ticket_updates';
  static const _kIncidentAlerts = 'notif_incident_alerts';
  static const _kMaintenanceAlerts = 'notif_maintenance_alerts';

  static NotificationPrefs _load(SharedPreferences p) => NotificationPrefs(
        comments: p.getBool(_kComments) ?? true,
        statusChanges: p.getBool(_kStatusChanges) ?? true,
        ticketUpdates: p.getBool(_kTicketUpdates) ?? true,
        incidentAlerts: p.getBool(_kIncidentAlerts) ?? true,
        maintenanceAlerts: p.getBool(_kMaintenanceAlerts) ?? true,
      );

  Future<void> setComments(bool v) =>
      _write(state.copyWith(comments: v), _kComments, v);
  Future<void> setStatusChanges(bool v) =>
      _write(state.copyWith(statusChanges: v), _kStatusChanges, v);
  Future<void> setTicketUpdates(bool v) =>
      _write(state.copyWith(ticketUpdates: v), _kTicketUpdates, v);
  Future<void> setIncidentAlerts(bool v) =>
      _write(state.copyWith(incidentAlerts: v), _kIncidentAlerts, v);
  Future<void> setMaintenanceAlerts(bool v) =>
      _write(state.copyWith(maintenanceAlerts: v), _kMaintenanceAlerts, v);

  Future<void> _write(NotificationPrefs next, String key, bool v) async {
    state = next;
    await _prefs.setBool(key, v);
  }
}

final notificationPrefsProvider =
    StateNotifierProvider<NotificationPrefsNotifier, NotificationPrefs>((ref) {
  return NotificationPrefsNotifier(ref.watch(sharedPreferencesProvider));
});

// ---------------------------------------------------------------------------
// Accounts list
// ---------------------------------------------------------------------------

final accountListProvider = FutureProvider<List<DeskAccount>>((ref) {
  return ref.read(accountRepositoryProvider).listAccounts();
});
