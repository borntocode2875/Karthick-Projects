import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/accounts/presentation/widgets/account_switcher_sheet.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';

/// Displays the active portal name and avatar; taps open the account switcher.
class AccountChip extends ConsumerWidget {
  const AccountChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final ctx = ref.watch(currentContextProvider);

    final portalName = ctx?.account.portalName ?? '—';
    final initial = ctx?.account.avatarInitial ?? '?';
    final colorHex = ctx?.account.avatarColor ?? '#888888';

    Color chipColor;
    try {
      final hex = colorHex.replaceFirst('#', '');
      chipColor = Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      chipColor = Colors.grey;
    }

    return GestureDetector(
      onTap: ctx == null ? null : () => showAccountSwitcherSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.line),
          borderRadius: BorderRadius.circular(AppSpacing.xxxxl),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PortalAvatar(initial: initial, color: chipColor),
            const SizedBox(width: AppSpacing.xs),
            Text(
              portalName,
              style: textTheme.labelMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _PortalAvatar extends StatelessWidget {
  const _PortalAvatar({required this.initial, required this.color});

  final String initial;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}
