import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
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

class _AppNavBar extends StatelessWidget {
  const _AppNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      destinations: const [
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.ticket),
          selectedIcon: Icon(PhosphorIconsFill.ticket),
          label: 'Tickets',
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.sparkle),
          selectedIcon: Icon(PhosphorIconsFill.sparkle),
          label: 'Zia',
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.warning),
          selectedIcon: Icon(PhosphorIconsFill.warning),
          label: 'Issues',
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.bell),
          selectedIcon: Icon(PhosphorIconsFill.bell),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.gear),
          selectedIcon: Icon(PhosphorIconsFill.gear),
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
