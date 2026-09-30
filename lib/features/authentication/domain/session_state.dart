import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';

/// Auth session lifecycle — loading → authenticated | unauthenticated.
sealed class SessionState {
  const SessionState();
}

final class SessionLoading extends SessionState {
  const SessionLoading();
}

final class SessionAuthenticated extends SessionState {
  const SessionAuthenticated(this.context);
  final AccountContext context;
}

final class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}
