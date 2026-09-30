import 'package:go_router/go_router.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:zoho_support_hub/features/ongoing_issues/presentation/screens/ongoing_issues_screen.dart';
import 'package:zoho_support_hub/features/settings/presentation/screens/settings_screen.dart';
import 'package:zoho_support_hub/features/tickets/presentation/screens/tickets_screen.dart';
import 'package:zoho_support_hub/features/zia/presentation/screens/zia_screen.dart';

// ---------------------------------------------------------------------------
// Route paths
// ---------------------------------------------------------------------------

abstract final class RoutePaths {
  static const tickets = '/tickets';
  static const zia = '/zia';
  static const ongoingIssues = '/issues';
  static const notifications = '/notifications';
  static const settings = '/settings';
}

// ---------------------------------------------------------------------------
// Router
// ---------------------------------------------------------------------------

final appRouter = GoRouter(
  initialLocation: RoutePaths.tickets,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.tickets,
              builder: (context, state) => const TicketsScreen(),
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
