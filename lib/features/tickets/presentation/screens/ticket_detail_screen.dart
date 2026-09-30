import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_comment.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/portal_config_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/ticket_detail_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/widgets/ticket_status_badge.dart';

// ---------------------------------------------------------------------------
// Main detail screen
// ---------------------------------------------------------------------------

class TicketDetailScreen extends ConsumerStatefulWidget {
  const TicketDetailScreen({required this.ticketId, super.key});

  final String ticketId;

  @override
  ConsumerState<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends ConsumerState<TicketDetailScreen> {
  final _replyController = TextEditingController();
  final _scrollController = ScrollController();
  bool _sending = false;

  @override
  void dispose() {
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final detail = ref.watch(ticketDetailProvider(widget.ticketId));
    final actions = ref.watch(ticketActionsProvider(widget.ticketId));
    final ctx = ref.watch(currentContextProvider);
    final TicketPermissions? permissions = ctx?.permissions;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        title: detail.whenOrNull(
          data: (d) => Text(
            '#${d.ticket.ticketNumber}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        actions: [
          if (actions is AsyncLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: detail.when(
        data: (d) => _DetailBody(
          ticket: d.ticket,
          comments: d.comments,
          permissions: permissions,
          replyController: _replyController,
          scrollController: _scrollController,
          sending: _sending,
          onSend: _sendReply,
          onStatusChange: _changeStatus,
          onPriorityChange: _changePriority,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _DetailError(
          message: e.toString(),
          onRetry: () => ref.refresh(ticketDetailProvider(widget.ticketId).future),
        ),
      ),
    );
  }

  Future<void> _sendReply() async {
    final content = _replyController.text.trim();
    if (content.isEmpty) return;
    setState(() => _sending = true);
    final ok = await ref
        .read(ticketActionsProvider(widget.ticketId).notifier)
        .addComment(content);
    if (ok && mounted) {
      _replyController.clear();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
    if (mounted) setState(() => _sending = false);
  }

  void _changeStatus(BuildContext ctx, Ticket ticket) {
    final portalConfig = ref.read(portalConfigProvider);
    final available = portalConfig.valueOrNull?.availableStatuses ?? TicketStatus.values;
    showModalBottomSheet<void>(
      context: ctx,
      builder: (_) => _StatusSheet(
        current: ticket.status,
        available: available,
        onSelect: (s) {
          Navigator.of(ctx).pop();
          ref.read(ticketActionsProvider(widget.ticketId).notifier).updateStatus(s);
        },
      ),
    );
  }

  void _changePriority(BuildContext ctx, Ticket ticket) {
    final portalConfig = ref.read(portalConfigProvider);
    final available =
        portalConfig.valueOrNull?.availablePriorities ?? TicketPriority.values;
    showModalBottomSheet<void>(
      context: ctx,
      builder: (_) => _PrioritySheet(
        current: ticket.priority,
        available: available,
        onSelect: (p) {
          Navigator.of(ctx).pop();
          ref
              .read(ticketActionsProvider(widget.ticketId).notifier)
              .updatePriority(p);
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Detail body
// ---------------------------------------------------------------------------

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.ticket,
    required this.comments,
    required this.permissions,
    required this.replyController,
    required this.scrollController,
    required this.sending,
    required this.onSend,
    required this.onStatusChange,
    required this.onPriorityChange,
  });

  final Ticket ticket;
  final List<TicketComment> comments;
  final TicketPermissions? permissions;
  final TextEditingController replyController;
  final ScrollController scrollController;
  final bool sending;
  final VoidCallback onSend;
  final void Function(BuildContext, Ticket) onStatusChange;
  final void Function(BuildContext, Ticket) onPriorityChange;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final canComment = permissions?.canAddComment ?? false;

    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.only(bottom: AppSpacing.base),
            children: [
              _TicketHeader(
                ticket: ticket,
                permissions: permissions,
                onStatusChange: onStatusChange,
                onPriorityChange: onPriorityChange,
              ),
              const Divider(height: 1),
              _DescriptionSection(description: ticket.description),
              if (comments.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenMargin, AppSpacing.base,
                    AppSpacing.screenMargin, AppSpacing.xs,
                  ),
                  child: Text(
                    'Replies (${comments.length})',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: colors.textSecondary,
                        ),
                  ),
                ),
                ...comments.map((c) => _CommentBubble(comment: c)),
              ],
            ],
          ),
        ),
        if (canComment)
          _ReplyBar(
            controller: replyController,
            sending: sending,
            onSend: onSend,
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Ticket header card
// ---------------------------------------------------------------------------

class _TicketHeader extends StatelessWidget {
  const _TicketHeader({
    required this.ticket,
    required this.permissions,
    required this.onStatusChange,
    required this.onPriorityChange,
  });

  final Ticket ticket;
  final TicketPermissions? permissions;
  final void Function(BuildContext, Ticket) onStatusChange;
  final void Function(BuildContext, Ticket) onPriorityChange;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final canStatus = permissions?.canChangeStatus ?? false;
    final canPriority = permissions?.canChangePriority ?? false;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticket.subject,
            style: textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              // Status chip
              _ActionChip(
                label: ticket.status.displayLabel,
                icon: TicketStatusBadge(ticket.status, small: true),
                enabled: canStatus && !ticket.status.isTerminal,
                onTap: canStatus && !ticket.status.isTerminal
                    ? () => onStatusChange(context, ticket)
                    : null,
              ),
              // Priority chip
              _ActionChip(
                label: ticket.priority.displayLabel,
                icon: PriorityIndicator(ticket.priority.barCount, size: 12),
                enabled: canPriority,
                onTap: canPriority ? () => onPriorityChange(context, ticket) : null,
              ),
              if (ticket.product != null)
                _InfoChip(label: ticket.product!),
              if (ticket.category != null)
                _InfoChip(label: ticket.category!),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              ExcludeSemantics(
                child: Icon(Icons.person, size: 14, color: colors.textTertiary),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                ticket.contactName,
                style: textTheme.labelSmall?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(width: AppSpacing.base),
              ExcludeSemantics(
                child: Icon(Icons.access_time, size: 14, color: colors.textTertiary),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                _formatDate(ticket.updatedAt),
                style: textTheme.labelSmall?.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 7) {
      return '${dt.day}/${dt.month}/${dt.year}';
    }
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.label,
    required this.icon,
    required this.enabled,
    this.onTap,
  });

  final String label;
  final Widget icon;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Semantics(
      button: enabled,
      label: enabled ? '$label, tap to change' : label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: colors.line),
            borderRadius: BorderRadius.circular(AppRadii.chip),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
              ),
              if (enabled) ...[
                const SizedBox(width: 2),
                Icon(Icons.keyboard_arrow_down,
                    size: 10, color: colors.textTertiary),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.line.withAlpha(60),
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
            ),
      ),
    );
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
            'Description',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Comment bubble
// ---------------------------------------------------------------------------

class _CommentBubble extends StatelessWidget {
  const _CommentBubble({required this.comment});
  final TicketComment comment;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isAgent = comment.authorType == CommentAuthorType.agent;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenMargin,
        vertical: AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment:
            isAgent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                isAgent ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (isAgent) ...[
                CircleAvatar(
                  radius: 10,
                  backgroundColor: colors.info.withAlpha(30),
                  child: Icon(Icons.headset_mic,
                      size: 12, color: colors.info),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                comment.authorName,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                _timeAgo(comment.createdAt),
                style: textTheme.labelSmall?.copyWith(color: colors.textTertiary),
              ),
              if (!isAgent) ...[
                const SizedBox(width: AppSpacing.xs),
                CircleAvatar(
                  radius: 10,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withAlpha(30),
                  child: Icon(Icons.person,
                      size: 12,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            decoration: BoxDecoration(
              color: isAgent ? colors.surface : colors.info.withAlpha(20),
              border: Border.all(
                color: isAgent
                    ? colors.line
                    : colors.info.withAlpha(60),
              ),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(AppRadii.card),
                topRight: const Radius.circular(AppRadii.card),
                bottomLeft: Radius.circular(isAgent ? 4 : AppRadii.card),
                bottomRight: Radius.circular(isAgent ? AppRadii.card : 4),
              ),
            ),
            child: Text(
              comment.content,
              style: textTheme.bodySmall?.copyWith(color: colors.textPrimary),
            ),
          ),
        ],
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
// Reply bar
// ---------------------------------------------------------------------------

class _ReplyBar extends StatelessWidget {
  const _ReplyBar({
    required this.controller,
    required this.sending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenMargin,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.line)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Reply…',
                  hintStyle: TextStyle(color: colors.textTertiary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.chip),
                    borderSide: BorderSide(color: colors.line),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.chip),
                    borderSide: BorderSide(color: colors.line),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton.filled(
              onPressed: sending ? null : onSend,
              tooltip: 'Send reply',
              icon: sending
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(PhosphorIconsRegular.paperPlaneTilt, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Status change sheet
// ---------------------------------------------------------------------------

class _StatusSheet extends StatelessWidget {
  const _StatusSheet({
    required this.current,
    required this.available,
    required this.onSelect,
  });

  final TicketStatus current;
  final List<TicketStatus> available;
  final void Function(TicketStatus) onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenMargin),
            child: Text(
              'Change Status',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),
          ...available.where((s) => s != current && !s.isTerminal).map((s) {
            return ListTile(
              leading: TicketStatusBadge(s),
              title: Text(s.displayLabel),
              onTap: () => onSelect(s),
            );
          }),
          ListTile(
            leading: Icon(PhosphorIconsRegular.x, color: colors.textSecondary),
            title: Text('Cancel',
                style: TextStyle(color: colors.textSecondary)),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Priority change sheet
// ---------------------------------------------------------------------------

class _PrioritySheet extends StatelessWidget {
  const _PrioritySheet({
    required this.current,
    required this.available,
    required this.onSelect,
  });

  final TicketPriority current;
  final List<TicketPriority> available;
  final void Function(TicketPriority) onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenMargin),
            child: Text(
              'Change Priority',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1),
          ...available.where((p) => p != current).map((p) {
            return ListTile(
              leading: PriorityIndicator(p.barCount),
              title: Text(p.displayLabel),
              onTap: () => onSelect(p),
            );
          }),
          ListTile(
            leading: Icon(PhosphorIconsRegular.x, color: colors.textSecondary),
            title: Text('Cancel',
                style: TextStyle(color: colors.textSecondary)),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error state
// ---------------------------------------------------------------------------

class _DetailError extends StatelessWidget {
  const _DetailError({required this.message, required this.onRetry});
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
              'Could not load ticket.',
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
