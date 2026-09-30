import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';

/// Global account chip shown in every tab's app bar.
///
/// Phase 1: displays a placeholder portal name and avatar.
/// Tapping opens the account switcher sheet (wired in Milestone 6).
class AccountChip extends StatelessWidget {
  const AccountChip({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _showAccountSwitcher(context),
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
            const _PortalAvatar(initial: 'N', color: Color(0xFF2F5BEA)),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Northwind Traders',
              style: textTheme.labelMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              PhosphorIconsRegular.caretDown,
              size: 14,
              color: colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountSwitcher(BuildContext context) {
    // Account switcher sheet wired in Milestone 6.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account switcher — coming in Milestone 6'),
        duration: Duration(seconds: 2),
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
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
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
