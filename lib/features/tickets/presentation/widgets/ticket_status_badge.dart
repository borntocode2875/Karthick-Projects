import 'package:flutter/material.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

/// Compact colored badge showing a ticket's status label.
class TicketStatusBadge extends StatelessWidget {
  const TicketStatusBadge(this.status, {super.key, this.small = false});

  final TicketStatus status;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final (bg, fg) = _colors(status, colors);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? AppSpacing.xs : AppSpacing.sm,
        vertical: small ? 2 : AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        status.displayLabel,
        style: (small ? textTheme.labelSmall : textTheme.labelSmall)?.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static (Color bg, Color fg) _colors(TicketStatus s, AppColors c) {
    return switch (s) {
      TicketStatus.open => (c.info.withAlpha(30), c.info),
      TicketStatus.inProgress => (c.warning.withAlpha(30), c.warning),
      TicketStatus.onHold => (c.textTertiary.withAlpha(30), c.textSecondary),
      TicketStatus.escalated => (c.danger.withAlpha(30), c.danger),
      TicketStatus.resolved => (c.success.withAlpha(30), c.success),
      TicketStatus.closed => (c.textTertiary.withAlpha(20), c.textTertiary),
    };
  }
}

/// Compact horizontal bar indicator for ticket priority.
class PriorityIndicator extends StatelessWidget {
  const PriorityIndicator(this.barCount, {super.key, this.size = 14.0});

  final int barCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final activeColor = _activeColor(barCount, colors);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 2,
      children: List.generate(4, (i) {
        final filled = i < barCount;
        return Container(
          width: size * 0.25,
          height: size * (0.5 + i * 0.17),
          decoration: BoxDecoration(
            color: filled ? activeColor : colors.line,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  static Color _activeColor(int bars, AppColors c) => switch (bars) {
        1 => c.textTertiary,
        2 => c.warning,
        3 => c.warning,
        _ => c.danger,
      };
}
