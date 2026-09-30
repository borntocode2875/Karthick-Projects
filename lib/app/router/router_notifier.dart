import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zoho_support_hub/app/router/routes.dart';
import 'package:zoho_support_hub/features/authentication/domain/session_state.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';

/// Bridges session state to GoRouter's refresh/redirect mechanism.
class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<SessionState>>(sessionProvider, (_, __) {
      notifyListeners();
    });
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final session = _ref.read(sessionProvider);

    // While the session is initialising, stay put.
    if (session is AsyncLoading) return null;

    final isAuthenticated = session.valueOrNull is SessionAuthenticated;
    final isOnLogin = state.matchedLocation == RoutePaths.login;

    if (!isAuthenticated && !isOnLogin) return RoutePaths.login;
    if (isAuthenticated && isOnLogin) return RoutePaths.tickets;
    return null;
  }
}
