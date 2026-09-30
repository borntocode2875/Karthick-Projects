import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/accounts/presentation/providers/account_provider.dart';
import 'package:zoho_support_hub/features/authentication/domain/session_state.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';

/// Shows a modal bottom sheet listing all saved accounts.
///
/// Tapping an inactive account switches to it.
/// The sign-out action clears the session and routes to login.
Future<void> showAccountSwitcherSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _AccountSwitcherSheet(),
  );
}

class _AccountSwitcherSheet extends ConsumerWidget {
  const _AccountSwitcherSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final accounts = ref.watch(accountListProvider);
    final session = ref.watch(sessionProvider);
    final isLoading = session is AsyncLoading;

    final currentId = session.whenOrNull(
      data: (s) => s is SessionAuthenticated ? s.context.accountId : null,
    );

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.sheet),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        AppSpacing.sm,
        AppSpacing.screenMargin,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.base),
              decoration: BoxDecoration(
                color: colors.line,
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
            ),
          ),

          Text(
            'Switch account',
            style: textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.base),

          accounts.when(
            data: (list) => Column(
              children: list.map((account) {
                final isActive = account.id == currentId;
                return _AccountTile(
                  account: account,
                  isActive: isActive,
                  isLoading: isLoading,
                  onTap: isActive || isLoading
                      ? null
                      : () async {
                          Navigator.of(context).pop();
                          await ref
                              .read(sessionProvider.notifier)
                              .switchAccount(account);
                        },
                );
              }).toList(),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const Divider(height: AppSpacing.xl),

          // Sign out
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.logout,
              color: colors.danger,
              size: 22,
            ),
            title: Text(
              'Sign out',
              style: textTheme.bodyMedium?.copyWith(color: colors.danger),
            ),
            onTap: isLoading
                ? null
                : () async {
                    Navigator.of(context).pop();
                    await ref.read(sessionProvider.notifier).signOut();
                  },
          ),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({
    required this.account,
    required this.isActive,
    required this.isLoading,
    required this.onTap,
  });

  final DeskAccount account;
  final bool isActive;
  final bool isLoading;
  final VoidCallback? onTap;

  Color _parseColor() {
    try {
      final hex = account.avatarColor.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final accent = _parseColor();

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          account.avatarInitial,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
      title: Text(
        account.portalName,
        style: textTheme.bodyMedium?.copyWith(
          color: colors.textPrimary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      subtitle: Text(
        account.orgName,
        style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
      ),
      trailing: isActive
          ? Icon(Icons.check_circle,
              color: Theme.of(context).colorScheme.primary, size: 20)
          : null,
      onTap: onTap,
    );
  }
}
