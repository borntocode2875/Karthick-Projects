import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/router/routes.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue.dart';
import 'package:zoho_support_hub/features/ongoing_issues/presentation/providers/ongoing_issue_providers.dart';

class OngoingIssuesScreen extends ConsumerWidget {
  const OngoingIssuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(ongoingIssueFilterProvider);
    final issues = ref.watch(ongoingIssueListProvider);

    return TabScaffold(
      title: 'Issues',
      actions: [
        if (!filter.isEmpty)
          IconButton(
            icon: Icon(
              PhosphorIconsFill.funnel,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () =>
                ref.read(ongoingIssueFilterProvider.notifier).reset(),
            tooltip: 'Clear filters',
          ),
      ],
      body: Column(
        children: [
          _FilterBar(filter: filter),
          Expanded(
            child: issues.when(
              data: (list) {
                if (list.isEmpty) {
                  return _EmptyState(hasFilter: !filter.isEmpty);
                }
                return RefreshIndicator(
                  onRefresh: () async =>
                      ref.refresh(ongoingIssueListProvider.future),
                  child: _IssueList(issues: list),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => _ErrorState(
                message: e.toString(),
                onRetry: () =>
                    ref.refresh(ongoingIssueListProvider.future),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filter bar
// ---------------------------------------------------------------------------

class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.filter});
  final OngoingIssueFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(ongoingIssueFilterProvider.notifier);

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenMargin,
          vertical: AppSpacing.xs,
        ),
        children: [
          // Data center filter
          ...DataCenter.values.map((dc) {
            final selected = filter.dataCenter == dc;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: FilterChip(
                label: Text(dc.displayName),
                selected: selected,
                onSelected: (_) =>
                    notifier.setDataCenter(selected ? null : dc),
                showCheckmark: false,
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Grouped issue list
// ---------------------------------------------------------------------------

class _IssueList extends StatelessWidget {
  const _IssueList({required this.issues});
  final List<OngoingIssue> issues;

  @override
  Widget build(BuildContext context) {
    final active = issues.where((i) => i.isActive).toList();
    final scheduled = issues.where((i) => i.isScheduled).toList();
    final resolved = issues.where((i) => i.isResolved).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxxxl + AppSpacing.xl),
      children: [
        if (active.isNotEmpty) ...[
          _SectionHeader('Active & Investigating', count: active.length),
          ...active.map((i) => _IssueCard(issue: i)),
        ],
        if (scheduled.isNotEmpty) ...[
          _SectionHeader('Scheduled Maintenance', count: scheduled.length),
          ...scheduled.map((i) => _IssueCard(issue: i)),
        ],
        if (resolved.isNotEmpty) ...[
          _SectionHeader('Recently Resolved', count: resolved.length),
          ...resolved.map((i) => _IssueCard(issue: i)),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin, AppSpacing.base,
        AppSpacing.screenMargin, AppSpacing.xs,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs, vertical: 1),
            decoration: BoxDecoration(
              color: colors.line.withAlpha(80),
              borderRadius: BorderRadius.circular(AppRadii.pill),
            ),
            child: Text(
              '$count',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Issue card
// ---------------------------------------------------------------------------

class _IssueCard extends StatelessWidget {
  const _IssueCard({required this.issue});
  final OngoingIssue issue;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenMargin,
        vertical: AppSpacing.xs,
      ),
      child: InkWell(
        onTap: () => context.push(RoutePaths.ongoingIssueDetail(issue.id)),
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _StatusBadge(issue.status),
                  const SizedBox(width: AppSpacing.xs),
                  _SeverityBadge(issue.severity),
                  const Spacer(),
                  Text(
                    _timeAgo(issue.updatedAt),
                    style: textTheme.labelSmall
                        ?.copyWith(color: colors.textTertiary),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                issue.title,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (issue.affectedProducts.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  children: issue.affectedProducts
                      .map((p) => _Pill(p, colors: colors))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}

// ---------------------------------------------------------------------------
// Badges
// ---------------------------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);
  final IssueStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final (bg, fg, label) = switch (status) {
      IssueStatus.active => (colors.danger.withAlpha(25), colors.danger, 'Active'),
      IssueStatus.investigating =>
        (colors.warning.withAlpha(25), colors.warning, 'Investigating'),
      IssueStatus.resolved =>
        (colors.success.withAlpha(25), colors.success, 'Resolved'),
      IssueStatus.scheduled =>
        (colors.info.withAlpha(25), colors.info, 'Scheduled'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SeverityBadge extends StatelessWidget {
  const _SeverityBadge(this.severity);
  final IssueSeverity severity;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final (fg, label) = switch (severity) {
      IssueSeverity.low => (colors.textTertiary, 'Low'),
      IssueSeverity.medium => (colors.info, 'Medium'),
      IssueSeverity.high => (colors.warning, 'High'),
      IssueSeverity.critical => (colors.danger, 'Critical'),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(PhosphorIconsFill.circle, size: 8, color: fg),
        const SizedBox(width: 3),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label, {required this.colors});
  final String label;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
      decoration: BoxDecoration(
        color: colors.line.withAlpha(80),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: colors.textSecondary),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty / error states
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasFilter});
  final bool hasFilter;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIconsRegular.checkCircle,
                size: 48, color: colors.success),
            const SizedBox(height: AppSpacing.base),
            Text(
              hasFilter
                  ? 'No issues match your filters.'
                  : 'All systems operational.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
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
              'Could not load issues.',
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
