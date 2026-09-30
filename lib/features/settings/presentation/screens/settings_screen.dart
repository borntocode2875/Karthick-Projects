import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/config/app_config.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/theme/app_accent.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/app/theme/theme_provider.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/settings/presentation/providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TabScaffold(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.only(
          top: AppSpacing.sm,
          bottom: AppSpacing.xxxxl + AppSpacing.xl,
        ),
        children: [
          const _SectionHeader('Appearance'),
          const _ThemeTile(),
          const _AccentTile(),
          const _SettingsDivider(),
          const _SectionHeader('Notifications'),
          const _NotificationsSection(),
          const _SettingsDivider(),
          const _SectionHeader('Accounts'),
          const _AccountsSection(),
          if (AppConfig.isMock) ...[
            const _SettingsDivider(),
            const _SectionHeader('Simulation'),
            const _SimulationSection(),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section chrome
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin, AppSpacing.base,
        AppSpacing.screenMargin, AppSpacing.xs,
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.textTertiary,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, indent: AppSpacing.screenMargin);
}

// ---------------------------------------------------------------------------
// Appearance — theme mode
// ---------------------------------------------------------------------------

class _ThemeTile extends ConsumerWidget {
  const _ThemeTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final current = ref.watch(themeModeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenMargin,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(PhosphorIconsRegular.deviceMobile, size: 16),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(PhosphorIconsRegular.sun, size: 16),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(PhosphorIconsRegular.moon, size: 16),
              ),
            ],
            selected: {current},
            onSelectionChanged: (modes) =>
                ref.read(themeModeProvider.notifier).setMode(modes.first),
            style: SegmentedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Appearance — accent colour
// ---------------------------------------------------------------------------

class _AccentTile extends ConsumerWidget {
  const _AccentTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final currentPreset = ref.watch(accentPresetProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin, AppSpacing.xs,
        AppSpacing.screenMargin, AppSpacing.base,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accent color',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (final preset in AccentPreset.values) ...[
                _AccentDot(
                  preset: preset,
                  isSelected: preset == currentPreset,
                  isDark: isDark,
                  onTap: () =>
                      ref.read(accentPresetProvider.notifier).setPreset(preset),
                ),
                if (preset != AccentPreset.values.last)
                  const SizedBox(width: AppSpacing.sm),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot({
    required this.preset,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final AccentPreset preset;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dotColor =
        isDark ? preset.darkPrimary : preset.lightPrimary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: dotColor,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2.5,
                )
              : null,
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Notifications section
// ---------------------------------------------------------------------------

class _NotificationsSection extends ConsumerWidget {
  const _NotificationsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(notificationPrefsProvider);
    final notifier = ref.read(notificationPrefsProvider.notifier);

    return Column(
      children: [
        _NotifToggle(
          icon: PhosphorIconsRegular.chatText,
          label: 'Comments',
          value: prefs.comments,
          onChanged: notifier.setComments,
        ),
        _NotifToggle(
          icon: PhosphorIconsRegular.arrowsClockwise,
          label: 'Status changes',
          value: prefs.statusChanges,
          onChanged: notifier.setStatusChanges,
        ),
        _NotifToggle(
          icon: PhosphorIconsRegular.ticket,
          label: 'Ticket updates',
          value: prefs.ticketUpdates,
          onChanged: notifier.setTicketUpdates,
        ),
        _NotifToggle(
          icon: PhosphorIconsRegular.warning,
          label: 'Incident alerts',
          value: prefs.incidentAlerts,
          onChanged: notifier.setIncidentAlerts,
        ),
        _NotifToggle(
          icon: PhosphorIconsRegular.wrench,
          label: 'Maintenance alerts',
          value: prefs.maintenanceAlerts,
          onChanged: notifier.setMaintenanceAlerts,
        ),
      ],
    );
  }
}

class _NotifToggle extends StatelessWidget {
  const _NotifToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return SwitchListTile(
      secondary: Icon(icon, size: 20, color: colors.textSecondary),
      title: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: colors.textPrimary),
      ),
      value: value,
      onChanged: onChanged,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenMargin,
        vertical: 0,
      ),
      dense: true,
    );
  }
}

// ---------------------------------------------------------------------------
// Accounts section
// ---------------------------------------------------------------------------

class _AccountsSection extends ConsumerWidget {
  const _AccountsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountListProvider);
    final activeAccountId =
        ref.watch(currentContextProvider)?.account.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        accounts.when(
          data: (list) => Column(
            children: [
              for (final account in list)
                _AccountTile(
                  account: account,
                  isActive: account.id == activeAccountId,
                ),
            ],
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.base),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              'Could not load accounts.',
              style: TextStyle(color: AppColors.of(context).danger),
            ),
          ),
        ),
        // Add account placeholder
        ListTile(
          leading: Icon(
            PhosphorIconsRegular.plusCircle,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            'Add account',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Live account addition coming in Phase 2.'),
              behavior: SnackBarBehavior.floating,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenMargin,
          ),
        ),
        // Sign out
        ListTile(
          leading: Icon(
            PhosphorIconsRegular.signOut,
            color: AppColors.of(context).danger,
          ),
          title: Text(
            'Sign out',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.of(context).danger,
                  fontWeight: FontWeight.w500,
                ),
          ),
          onTap: () => _confirmSignOut(context, ref),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenMargin,
          ),
        ),
      ],
    );
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text(
          'You will need to sign in again to access your tickets.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(sessionProvider.notifier).signOut();
    }
  }
}

class _AccountTile extends ConsumerWidget {
  const _AccountTile({
    required this.account,
    required this.isActive,
  });

  final DeskAccount account;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final avatarColor = _parseHex(account.avatarColor);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: avatarColor,
        radius: 18,
        child: Text(
          account.avatarInitial,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
      title: Text(
        account.orgName,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
      ),
      subtitle: Text(
        '${account.portalName} · ${account.dataCenter.displayName}',
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive)
            Icon(
              PhosphorIconsFill.checkCircle,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          if (!isActive) ...[
            IconButton(
              icon: Icon(PhosphorIconsRegular.trash,
                  size: 18, color: colors.danger),
              onPressed: () => _confirmRemove(context, ref),
              tooltip: 'Remove account',
            ),
          ] else ...[
            const SizedBox(width: AppSpacing.xs),
          ],
        ],
      ),
      onTap: isActive
          ? null
          : () => ref
              .read(sessionProvider.notifier)
              .switchAccount(account),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenMargin,
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remove account?'),
        content: Text(
          'This will remove ${account.orgName} from the app. '
          'Your tickets and data on Zoho Desk are not affected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.of(context).danger,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final repo = ref.read(accountRepositoryProvider);
    await repo.removeAccount(account.id);
    ref.invalidate(accountListProvider);

    // If this was the active account, sign out (router redirects to login).
    final remaining = await repo.listAccounts();
    if (remaining.isEmpty) {
      ref.read(sessionProvider.notifier).signOut();
    } else {
      ref.read(sessionProvider.notifier).switchAccount(remaining.first);
    }
  }

  static Color _parseHex(String hex) {
    final clean = hex.replaceFirst('#', '');
    return Color(int.parse('FF$clean', radix: 16));
  }
}

// ---------------------------------------------------------------------------
// Simulation section (mock mode only)
// ---------------------------------------------------------------------------

class _SimulationSection extends ConsumerWidget {
  const _SimulationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final activeAccountId =
        ref.watch(currentContextProvider)?.account.id;

    final portals = [
      (
        account: mockAccountA,
        label: 'Portal A — Northwind Traders',
        subtitle: 'Full permissions · India DC',
      ),
      (
        account: mockAccountB,
        label: 'Portal B — Brightline Analytics',
        subtitle: 'No priority change · US DC',
      ),
      (
        account: mockAccountC,
        label: 'Portal C — Harbor Health',
        subtitle: 'Full permissions · India DC',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.xs,
          ),
          child: Text(
            'Switch active portal context to explore different permission sets.',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: colors.textSecondary),
          ),
        ),
        for (final p in portals)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: _parseHex(p.account.avatarColor),
              radius: 16,
              child: Text(
                p.account.avatarInitial,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            title: Text(
              p.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: p.account.id == activeAccountId
                        ? colors.textTertiary
                        : colors.textPrimary,
                  ),
            ),
            subtitle: Text(
              p.subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: colors.textSecondary),
            ),
            trailing: p.account.id == activeAccountId
                ? Icon(
                    PhosphorIconsFill.checkCircle,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: p.account.id == activeAccountId
                ? null
                : () => ref
                    .read(sessionProvider.notifier)
                    .switchAccount(p.account),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenMargin,
            ),
          ),
      ],
    );
  }

  static Color _parseHex(String hex) {
    final clean = hex.replaceFirst('#', '');
    return Color(int.parse('FF$clean', radix: 16));
  }
}
