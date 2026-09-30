import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/notifications/presentation/providers/notification_providers.dart';
import 'package:zoho_support_hub/shared/components/account_chip.dart';

/// Root scaffold that hosts the five-tab bottom navigation shell.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _AppNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // Return to initial location when tapping the active tab.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

// ---------------------------------------------------------------------------
// Navigation bar
// ---------------------------------------------------------------------------

class _AppNavBar extends ConsumerWidget {
  const _AppNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final unreadCount = ref.watch(unreadCountProvider);

    final badgeLabel = unreadCount > 9 ? '9+' : '$unreadCount';
    final showBadge = unreadCount > 0;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.confirmation_number_outlined),
          selectedIcon: Icon(Icons.confirmation_number),
          label: 'Tickets',
        ),
        const NavigationDestination(
          icon: Icon(Icons.auto_awesome_outlined),
          selectedIcon: Icon(Icons.auto_awesome),
          label: 'Zia',
        ),
        const NavigationDestination(
          icon: Icon(Icons.warning_amber_outlined),
          selectedIcon: Icon(Icons.warning),
          label: 'Issues',
        ),
        NavigationDestination(
          icon: Badge(
            isLabelVisible: showBadge,
            label: Text(badgeLabel),
            child: const Icon(Icons.notifications_outlined),
          ),
          selectedIcon: Badge(
            isLabelVisible: showBadge,
            label: Text(badgeLabel),
            child: const Icon(Icons.notifications),
          ),
          label: 'Notifications',
        ),
        const NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared tab scaffold — used by each feature screen
// ---------------------------------------------------------------------------

/// Standard tab scaffold with the account chip in the app bar.
class TabScaffold extends StatelessWidget {
  const TabScaffold({
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    super.key,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        titleSpacing: AppSpacing.screenMargin,
        title: const AccountChip(),
        actions: [
          if (actions != null) ...actions!,
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
