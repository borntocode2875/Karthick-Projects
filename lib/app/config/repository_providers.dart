import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/app_config.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';
import 'package:zoho_support_hub/core/http/token_storage.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_account_repository.dart';
import 'package:zoho_support_hub/features/accounts/data/zoho_account_repository.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_repository.dart';
import 'package:zoho_support_hub/features/authentication/data/mock_auth_repository.dart';
import 'package:zoho_support_hub/features/authentication/data/zoho_auth_repository.dart';
import 'package:zoho_support_hub/features/authentication/domain/auth_repository.dart';
import 'package:zoho_support_hub/features/notifications/data/mock_notification_repository.dart';
import 'package:zoho_support_hub/features/notifications/data/zoho_notification_repository.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_repository.dart';
import 'package:zoho_support_hub/features/ongoing_issues/data/mock_ongoing_issue_repository.dart';
import 'package:zoho_support_hub/features/ongoing_issues/data/zoho_ongoing_issue_repository.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue_repository.dart';
import 'package:zoho_support_hub/features/tickets/data/mock_portal_config_repository.dart';
import 'package:zoho_support_hub/features/tickets/data/mock_ticket_repository.dart';
import 'package:zoho_support_hub/features/tickets/data/zoho_ticket_repository.dart';
import 'package:zoho_support_hub/features/tickets/domain/portal_configuration_repository.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_repository.dart';
import 'package:zoho_support_hub/features/zia/data/mock_zia_repository.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_repository.dart';

// ---------------------------------------------------------------------------
// Shared infrastructure providers
// ---------------------------------------------------------------------------

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

// ---------------------------------------------------------------------------
// Repository providers — mock vs. live selected by APP_ENV dart-define
// ---------------------------------------------------------------------------

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (AppConfig.isMock) return MockAuthRepository();
  return ZohoAuthRepository(tokenStorage: ref.read(tokenStorageProvider));
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  if (AppConfig.isMock) return MockAccountRepository();
  final prefs = ref.watch(sharedPreferencesProvider);
  return ZohoAccountRepository(prefs);
});

final portalConfigurationRepositoryProvider =
    Provider<PortalConfigurationRepository>((ref) {
  // Phase 2: Portal config is fetched from Zoho Desk /portals/{id}/configuration.
  // For now both modes use the mock; replace with ZohoPortalConfigRepository when
  // the portal configuration API is finalized.
  return MockPortalConfigurationRepository();
});

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  if (AppConfig.isMock) return MockTicketRepository();
  return ZohoTicketRepository(tokenStorage: ref.read(tokenStorageProvider));
});

final ziaRepositoryProvider = Provider<ZiaRepository>((ref) {
  // Zia live integration requires the Zoho Desk Zia API (internal).
  // Mock is used for both phases until the API is available.
  return MockZiaRepository();
});

final ongoingIssueRepositoryProvider = Provider<OngoingIssueRepository>((ref) {
  if (AppConfig.isMock) return MockOngoingIssueRepository();
  return ZohoOngoingIssueRepository();
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  if (AppConfig.isMock) return MockNotificationRepository();
  return ZohoNotificationRepository(tokenStorage: ref.read(tokenStorageProvider));
});
