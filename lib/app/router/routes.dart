import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/router/router_notifier.dart';
import 'package:zoho_support_hub/features/authentication/presentation/screens/login_screen.dart';
import 'package:zoho_support_hub/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:zoho_support_hub/features/ongoing_issues/presentation/screens/ongoing_issues_screen.dart';
import 'package:zoho_support_hub/features/settings/presentation/screens/settings_screen.dart';
import 'package:zoho_support_hub/features/tickets/presentation/screens/ticket_detail_screen.dart';
import 'package:zoho_support_hub/features/tickets/presentation/screens/tickets_screen.dart';
import 'package:zoho_support_hub/features/zia/presentation/screens/zia_screen.dart';

// ---------------------------------------------------------------------------
// Route paths
// ---------------------------------------------------------------------------

abstract final class RoutePaths {
  static const login = '/login';
  static const tickets = '/tickets';
  static const createTicket = '/tickets/new';
  static const zia = '/zia';
  static const ongoingIssues = '/issues';
  static const notifications = '/notifications';
  static const settings = '/settings';

  static String ticketDetail(String id) => '/tickets/$id';
}

// ---------------------------------------------------------------------------
// Router (Riverpod provider so redirect can read session state)
// ---------------------------------------------------------------------------

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  final router = GoRouter(
    initialLocation: RoutePaths.tickets,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.tickets,
                builder: (context, state) => const TicketsScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (context, state) => const CreateTicketPlaceholderScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        TicketDetailScreen(ticketId: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.zia,
                builder: (context, state) => const ZiaScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ongoingIssues,
                builder: (context, state) => const OngoingIssuesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.notifications,
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
