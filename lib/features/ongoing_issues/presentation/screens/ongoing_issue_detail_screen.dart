import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue.dart';
import 'package:zoho_support_hub/features/ongoing_issues/presentation/providers/ongoing_issue_providers.dart';

class OngoingIssueDetailScreen extends ConsumerWidget {
  const OngoingIssueDetailScreen({required this.issueId, super.key});

  final String issueId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final detail = ref.watch(ongoingIssueDetailProvider(issueId));

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Issue Detail',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: detail.when(
        data: (issue) => _IssueBody(issue: issue),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorState(
          message: e.toString(),
          onRetry: () =>
              ref.refresh(ongoingIssueDetailProvider(issueId).future),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Issue body
// ---------------------------------------------------------------------------

class _IssueBody extends StatelessWidget {
  const _IssueBody({required this.issue});
  final OngoingIssue issue;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxxxl),
      children: [
        _IssueHeader(issue: issue),
        const Divider(height: 1),
        _DescriptionSection(description: issue.description),
        _AffectedSection(issue: issue),
        if (issue.timeline.isNotEmpty) _TimelineSection(issue: issue),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _IssueHeader extends StatelessWidget {
  const _IssueHeader({required this.issue});
  final OngoingIssue issue;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusBadge(issue.status),
              const SizedBox(width: AppSpacing.xs),
              _SeverityBadge(issue.severity),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            issue.title,
            style: textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.access_time,
                  size: 14, color: colors.textTertiary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Started ${_formatDate(issue.startedAt)}',
                style:
                    textTheme.labelSmall?.copyWith(color: colors.textSecondary),
              ),
              if (issue.resolvedAt != null) ...[
                const SizedBox(width: AppSpacing.base),
                Icon(Icons.check_circle,
                    size: 14, color: colors.success),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Resolved ${_formatDate(issue.resolvedAt!)}',
                  style: textTheme.labelSmall
                      ?.copyWith(color: colors.textSecondary),
                ),
              ],
              if (issue.scheduledFor != null) ...[
                const SizedBox(width: AppSpacing.base),
                Icon(Icons.calendar_today,
                    size: 14, color: colors.info),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Scheduled ${_formatDate(issue.scheduledFor!)}',
                  style: textTheme.labelSmall
                      ?.copyWith(color: colors.textSecondary),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

// ---------------------------------------------------------------------------
// Description
// ---------------------------------------------------------------------------

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Affected products + DCs
// ---------------------------------------------------------------------------

class _AffectedSection extends StatelessWidget {
  const _AffectedSection({required this.issue});
  final OngoingIssue issue;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin, 0,
        AppSpacing.screenMargin, AppSpacing.base,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (issue.affectedProducts.isNotEmpty) ...[
            Text(
              'Affected products',
              style: textTheme.labelMedium
                  ?.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: issue.affectedProducts
                  .map((p) => _Chip(p, colors: colors))
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (issue.affectedDataCenters.isNotEmpty) ...[
            Text(
              'Affected data centers',
              style: textTheme.labelMedium
                  ?.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: issue.affectedDataCenters
                  .map((dc) => _Chip(dc.displayName, colors: colors))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.label, {required this.colors});
  final String label;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
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
// Timeline
// ---------------------------------------------------------------------------

class _TimelineSection extends StatelessWidget {
  const _TimelineSection({required this.issue});
  final OngoingIssue issue;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin, 0,
        AppSpacing.screenMargin, 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Show newest first
          ...issue.timeline.reversed.toList().asMap().entries.map((entry) {
            final i = entry.key;
            final update = entry.value;
            final isLast = i == issue.timeline.length - 1;
            return _TimelineEntry(
              update: update,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.update, required this.isLast});
  final IssueUpdate update;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    final dotColor = switch (update.status) {
      IssueStatus.active => colors.danger,
      IssueStatus.investigating => colors.warning,
      IssueStatus.resolved => colors.success,
      IssueStatus.scheduled => colors.info,
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline spine
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: colors.line,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.base),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _StatusLabel(update.status),
                      const Spacer(),
                      Text(
                        _formatDateTime(update.timestamp),
                        style: textTheme.labelSmall
                            ?.copyWith(color: colors.textTertiary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    update.content,
                    style: textTheme.bodySmall
                        ?.copyWith(color: colors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDateTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day}/${dt.month} $h:$m';
  }
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel(this.status);
  final IssueStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final (color, label) = switch (status) {
      IssueStatus.active => (colors.danger, 'Active'),
      IssueStatus.investigating => (colors.warning, 'Investigating'),
      IssueStatus.resolved => (colors.success, 'Resolved'),
      IssueStatus.scheduled => (colors.info, 'Scheduled'),
    };
    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

// ---------------------------------------------------------------------------
// Status / severity badges (re-used from list screen)
// ---------------------------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);
  final IssueStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final (bg, fg, label) = switch (status) {
      IssueStatus.active =>
        (colors.danger.withAlpha(25), colors.danger, 'Active'),
      IssueStatus.investigating =>
        (colors.warning.withAlpha(25), colors.warning, 'Investigating'),
      IssueStatus.resolved =>
        (colors.success.withAlpha(25), colors.success, 'Resolved'),
      IssueStatus.scheduled =>
        (colors.info.withAlpha(25), colors.info, 'Scheduled'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
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
        Icon(Icons.circle, size: 8, color: fg),
        const SizedBox(width: 3),
        Text(
          label,
          style:
              Theme.of(context).textTheme.labelSmall?.copyWith(color: fg),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Error state
// ---------------------------------------------------------------------------

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
            Icon(Icons.error,
                size: 40, color: colors.danger),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Could not load issue details.',
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
