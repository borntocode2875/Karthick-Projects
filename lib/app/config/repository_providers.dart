import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/app_config.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_account_repository.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_repository.dart';
import 'package:zoho_support_hub/features/authentication/data/mock_auth_repository.dart';
import 'package:zoho_support_hub/features/authentication/domain/auth_repository.dart';
import 'package:zoho_support_hub/features/notifications/data/mock_notification_repository.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_repository.dart';
import 'package:zoho_support_hub/features/ongoing_issues/data/mock_ongoing_issue_repository.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue_repository.dart';
import 'package:zoho_support_hub/features/tickets/data/mock_portal_config_repository.dart';
import 'package:zoho_support_hub/features/tickets/data/mock_ticket_repository.dart';
import 'package:zoho_support_hub/features/tickets/domain/portal_configuration_repository.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_repository.dart';
import 'package:zoho_support_hub/features/zia/data/mock_zia_repository.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_repository.dart';

// ---------------------------------------------------------------------------
// Repository providers
//
// Each provider selects mock or live implementation based on APP_ENV.
// Swapping to live requires zero screen changes.
// ---------------------------------------------------------------------------

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (AppConfig.isMock) return MockAuthRepository();
  throw UnimplementedError('Live AuthRepository not yet implemented.');
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  if (AppConfig.isMock) return MockAccountRepository();
  throw UnimplementedError('Live AccountRepository not yet implemented.');
});

final portalConfigurationRepositoryProvider =
    Provider<PortalConfigurationRepository>((ref) {
  if (AppConfig.isMock) return MockPortalConfigurationRepository();
  throw UnimplementedError('Live PortalConfigurationRepository not yet implemented.');
});

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  if (AppConfig.isMock) return MockTicketRepository();
  throw UnimplementedError('Live TicketRepository not yet implemented.');
});

final ziaRepositoryProvider = Provider<ZiaRepository>((ref) {
  if (AppConfig.isMock) return MockZiaRepository();
  throw UnimplementedError('Live ZiaRepository not yet implemented.');
});

final ongoingIssueRepositoryProvider = Provider<OngoingIssueRepository>((ref) {
  if (AppConfig.isMock) return MockOngoingIssueRepository();
  throw UnimplementedError('Live OngoingIssueRepository not yet implemented.');
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  if (AppConfig.isMock) return MockNotificationRepository();
  throw UnimplementedError('Live NotificationRepository not yet implemented.');
});
