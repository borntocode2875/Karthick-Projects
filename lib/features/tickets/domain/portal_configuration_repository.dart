import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/tickets/domain/portal_configuration.dart';

abstract class PortalConfigurationRepository {
  /// Fetches the full portal configuration for [context].
  ///
  /// Implementations may cache this per (accountId, portalId) pair.
  /// Throws [AuthorizationError] if the portal is not accessible.
  Future<PortalConfiguration> getConfiguration(AccountContext context);
}
