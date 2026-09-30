import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/router/routes.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_item.dart';
import 'package:zoho_support_hub/features/notifications/presentation/providers/notification_providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationListProvider);
    final actions = ref.watch(notificationActionsProvider);
    final hasUnread = ref.watch(unreadCountProvider) > 0;

    return TabScaffold(
      title: 'Notifications',
      actions: [
        if (hasUnread)
          actions is AsyncLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : TextButton(
                  onPressed: () =>
                      ref.read(notificationActionsProvider.notifier).markAllRead(),
                  child: const Text('Mark all read'),
                ),
      ],
      body: notifications.when(
        data: (list) {
          if (list.isEmpty) return const _EmptyState();
          return RefreshIndicator(
            onRefresh: () async =>
                ref.refresh(notificationListProvider.future),
            child: _NotificationList(notifications: list),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorState(
          message: e.toString(),
          onRetry: () => ref.refresh(notificationListProvider.future),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Grouped list
// ---------------------------------------------------------------------------

class _NotificationList extends ConsumerWidget {
  const _NotificationList({required this.notifications});
  final List<NotificationItem> notifications;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final todayItems = notifications
        .where((n) => _dateOf(n.receivedAt).isAtSameMomentAs(today))
        .toList();
    final yesterdayItems = notifications
        .where((n) => _dateOf(n.receivedAt).isAtSameMomentAs(yesterday))
        .toList();
    final earlierItems = notifications
        .where((n) => _dateOf(n.receivedAt).isBefore(yesterday))
        .toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxxxl + AppSpacing.xl),
      children: [
        if (todayItems.isNotEmpty) ...[
          const _GroupHeader('Today'),
          ...todayItems.map((n) => _NotificationTile(notification: n)),
        ],
        if (yesterdayItems.isNotEmpty) ...[
          const _GroupHeader('Yesterday'),
          ...yesterdayItems.map((n) => _NotificationTile(notification: n)),
        ],
        if (earlierItems.isNotEmpty) ...[
          const _GroupHeader('Earlier'),
          ...earlierItems.map((n) => _NotificationTile(notification: n)),
        ],
      ],
    );
  }

  static DateTime _dateOf(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader(this.label);
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
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Notification tile
// ---------------------------------------------------------------------------

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.notification});
  final NotificationItem notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isRead = notification.isRead;

    return InkWell(
      onTap: () => _handleTap(context, ref),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenMargin,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(right: AppSpacing.sm, top: 2),
              decoration: BoxDecoration(
                color: _iconBg(notification.type, colors),
                borderRadius: BorderRadius.circular(AppRadii.chip),
              ),
              child: Icon(
                _iconFor(notification.type),
                size: 18,
                color: _iconFg(notification.type, colors),
              ),
            ),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: isRead
                                ? FontWeight.normal
                                : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        _timeAgo(notification.receivedAt),
                        style: textTheme.labelSmall
                            ?.copyWith(color: colors.textTertiary),
                      ),
                      if (!isRead) ...[
                        const SizedBox(width: AppSpacing.xs),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.body,
                    style: textTheme.bodySmall?.copyWith(
                      color: isRead ? colors.textTertiary : colors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleTap(BuildContext context, WidgetRef ref) async {
    // Mark read first (non-blocking)
    if (!notification.isRead) {
      ref
          .read(notificationActionsProvider.notifier)
          .markRead(notification.id);
    }

    // Navigate based on target — always fetches fresh data at the target screen
    // (security rule: deep links re-resolve context and fetch fresh data)
    switch (notification.targetType) {
      case NotificationTargetType.ticket:
        context.push(RoutePaths.ticketDetail(notification.targetId));
      case NotificationTargetType.issue:
        context.push(RoutePaths.ongoingIssueDetail(notification.targetId));
      case NotificationTargetType.account:
        context.go(RoutePaths.tickets);
    }
  }

  static IconData _iconFor(NotificationType type) => switch (type) {
        NotificationType.comment => PhosphorIconsRegular.chatText,
        NotificationType.statusChange => PhosphorIconsRegular.arrowsClockwise,
        NotificationType.ticketUpdate => PhosphorIconsRegular.ticket,
        NotificationType.incidentAlert => PhosphorIconsRegular.warning,
        NotificationType.maintenanceAlert => PhosphorIconsRegular.wrench,
      };

  static Color _iconBg(NotificationType type, AppColors c) => switch (type) {
        NotificationType.comment => c.info.withAlpha(25),
        NotificationType.statusChange => c.warning.withAlpha(25),
        NotificationType.ticketUpdate => c.info.withAlpha(25),
        NotificationType.incidentAlert => c.danger.withAlpha(25),
        NotificationType.maintenanceAlert => c.warning.withAlpha(25),
      };

  static Color _iconFg(NotificationType type, AppColors c) => switch (type) {
        NotificationType.comment => c.info,
        NotificationType.statusChange => c.warning,
        NotificationType.ticketUpdate => c.info,
        NotificationType.incidentAlert => c.danger,
        NotificationType.maintenanceAlert => c.warning,
      };

  static String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }
}

// ---------------------------------------------------------------------------
// Empty / error states
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIconsRegular.bellSlash,
                size: 48, color: colors.textTertiary),
            const SizedBox(height: AppSpacing.base),
            Text(
              'No notifications yet.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIconsRegular.warningCircle,
                size: 40, color: colors.danger),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Could not load notifications.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
