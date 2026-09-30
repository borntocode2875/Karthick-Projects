import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/router/routes.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/ticket_list_provider.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_action.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_chat_message.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_response.dart';

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class ZiaScreen extends ConsumerStatefulWidget {
  const ZiaScreen({super.key});

  @override
  ConsumerState<ZiaScreen> createState() => _ZiaScreenState();
}

class _ZiaScreenState extends ConsumerState<ZiaScreen> {
  final _messages = <ZiaChatMessage>[];
  final _responses = <String, ZiaResponse>{}; // messageId → full response
  final _actions = <String, ZiaAction>{}; // actionId → current action state
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  var _typing = false;
  String? _errorBanner;

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return TabScaffold(
      title: 'Zia',
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.ziaGradientStart.withAlpha(15),
              colors.background,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? _WelcomeView(onSuggestion: _fillSuggestion)
                  : _MessageList(
                      messages: _messages,
                      responses: _responses,
                      actions: _actions,
                      typing: _typing,
                      scrollController: _scrollController,
                      onConfirm: _confirmAction,
                      onReject: _rejectAction,
                    ),
            ),
            if (_errorBanner != null)
              _ErrorBanner(
                message: _errorBanner!,
                onDismiss: () => setState(() => _errorBanner = null),
              ),
            _ComposerBar(
              controller: _inputController,
              enabled: !_typing,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  void _fillSuggestion(String text) {
    _inputController.text = text;
    _inputController.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _typing) return;

    final ctx = ref.read(currentContextProvider);
    if (ctx == null) return;

    _inputController.clear();

    final userMsg = ZiaChatMessage(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      role: ZiaMessageRole.user,
      content: text,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
      _typing = true;
      _errorBanner = null;
    });
    _scheduleScrollToBottom();

    try {
      final response = await ref.read(ziaRepositoryProvider).sendMessage(
            context: ctx,
            message: text,
            history: List.unmodifiable(_messages),
          );

      if (!mounted) return;

      final ziaMsg = ZiaChatMessage(
        id: response.messageId,
        role: ZiaMessageRole.zia,
        content: response.text,
        timestamp: DateTime.now(),
        actionId: response.proposedAction?.id,
      );

      setState(() {
        _messages.add(ziaMsg);
        _responses[response.messageId] = response;
        _typing = false;
        if (response.proposedAction != null) {
          _actions[response.proposedAction!.id] = response.proposedAction!;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _typing = false;
        _errorBanner = e.toString().replaceFirst('Exception: ', '');
      });
    }
    _scheduleScrollToBottom();
  }

  Future<void> _confirmAction(ZiaAction action) async {
    final ctx = ref.read(currentContextProvider);
    if (ctx == null) return;

    // Optimistically mark confirmed in UI
    setState(() => _actions[action.id] = action.copyWith(isConfirmed: true));

    try {
      await ref
          .read(ziaRepositoryProvider)
          .confirmAction(context: ctx, action: action);

      // Execute through the same repository path as direct UI actions
      final repo = ref.read(ticketRepositoryProvider);
      final type = action.type;

      if (type == ZiaActionType.changeStatus &&
          action.ticketId != null &&
          action.toStatus != null) {
        await repo.updateTicketStatus(
          context: ctx,
          ticketId: action.ticketId!,
          status: action.toStatus!,
        );
      } else if (type == ZiaActionType.changePriority &&
          action.ticketId != null &&
          action.toPriority != null) {
        await repo.updateTicketPriority(
          context: ctx,
          ticketId: action.ticketId!,
          priority: action.toPriority!,
        );
      } else if (type == ZiaActionType.addComment &&
          action.ticketId != null &&
          action.commentContent != null) {
        await repo.addComment(
          context: ctx,
          ticketId: action.ticketId!,
          content: action.commentContent!,
        );
      } else if (type == ZiaActionType.createTicket &&
          action.createInput != null) {
        await repo.createTicket(context: ctx, input: action.createInput!);
      }

      ref.invalidate(ticketListProvider);

      if (!mounted) return;
      final doneMsg = ZiaChatMessage(
        id: 'zia-done-${DateTime.now().millisecondsSinceEpoch}',
        role: ZiaMessageRole.zia,
        content: '${action.confirmLabel} completed.',
        timestamp: DateTime.now(),
      );
      setState(() => _messages.add(doneMsg));
      _scheduleScrollToBottom();
    } catch (e) {
      if (!mounted) return;
      // Roll back optimistic update
      setState(() => _actions[action.id] = action);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'This action isn\'t available right now. Please try again.')),
      );
    }
  }

  Future<void> _rejectAction(ZiaAction action) async {
    final ctx = ref.read(currentContextProvider);
    if (ctx == null) return;

    await ref
        .read(ziaRepositoryProvider)
        .rejectAction(context: ctx, action: action);

    if (!mounted) return;
    final cancelMsg = ZiaChatMessage(
      id: 'zia-cancel-${DateTime.now().millisecondsSinceEpoch}',
      role: ZiaMessageRole.zia,
      content: 'No problem, I\'ve cancelled that.',
      timestamp: DateTime.now(),
    );
    setState(() {
      _actions[action.id] = action.copyWith(isRejected: true);
      _messages.add(cancelMsg);
    });
    _scheduleScrollToBottom();
  }

  void _scheduleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

// ---------------------------------------------------------------------------
// Welcome view (no messages yet)
// ---------------------------------------------------------------------------

class _WelcomeView extends StatelessWidget {
  const _WelcomeView({required this.onSuggestion});
  final void Function(String) onSuggestion;

  static const _suggestions = [
    'Check my tickets',
    'Is Zoho CRM down?',
    'Mark ticket resolved',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [colors.ziaGradientStart, colors.ziaGradientEnd],
              ).createShader(bounds),
              child: const Icon(
                Icons.auto_awesome,
                size: 56,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            Text(
              'Ask Zia',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colors.textPrimary,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Check ticket status, look up service incidents, and more.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              alignment: WrapAlignment.center,
              children: _suggestions
                  .map((s) => ActionChip(
                        label: Text(s),
                        onPressed: () => onSuggestion(s),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Message list
// ---------------------------------------------------------------------------

class _MessageList extends StatelessWidget {
  const _MessageList({
    required this.messages,
    required this.responses,
    required this.actions,
    required this.typing,
    required this.scrollController,
    required this.onConfirm,
    required this.onReject,
  });

  final List<ZiaChatMessage> messages;
  final Map<String, ZiaResponse> responses;
  final Map<String, ZiaAction> actions;
  final bool typing;
  final ScrollController scrollController;
  final void Function(ZiaAction) onConfirm;
  final void Function(ZiaAction) onReject;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.base),
      itemCount: messages.length + (typing ? 1 : 0),
      itemBuilder: (_, i) {
        if (i == messages.length) return const _TypingBubble();

        final msg = messages[i];
        if (msg.role == ZiaMessageRole.user) {
          return _UserBubble(message: msg);
        }

        final response = responses[msg.id];
        final action = msg.actionId != null ? actions[msg.actionId] : null;

        return _ZiaBubble(
          message: msg,
          referencedTicketIds:
              response?.referencedTicketIds ?? const [],
          referencedIssueIds:
              response?.referencedIssueIds ?? const [],
          action: action,
          onConfirm: onConfirm,
          onReject: onReject,
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// User message bubble
// ---------------------------------------------------------------------------

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.message});
  final ZiaChatMessage message;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxxxl, AppSpacing.xs,
        AppSpacing.screenMargin, AppSpacing.xs,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadii.card),
              topRight: Radius.circular(AppRadii.card),
              bottomLeft: Radius.circular(AppRadii.card),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Text(
            message.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Zia message bubble
// ---------------------------------------------------------------------------

class _ZiaBubble extends StatelessWidget {
  const _ZiaBubble({
    required this.message,
    required this.referencedTicketIds,
    required this.referencedIssueIds,
    required this.action,
    required this.onConfirm,
    required this.onReject,
  });

  final ZiaChatMessage message;
  final List<String> referencedTicketIds;
  final List<String> referencedIssueIds;
  final ZiaAction? action;
  final void Function(ZiaAction) onConfirm;
  final void Function(ZiaAction) onReject;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin, AppSpacing.xs,
        AppSpacing.xxxxl, AppSpacing.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Zia avatar
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(top: 2, right: AppSpacing.xs),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.ziaGradientStart, colors.ziaGradientEnd],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 14,
              color: Colors.white,
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message bubble
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    border: Border.all(color: colors.line),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(AppRadii.card),
                      bottomLeft: Radius.circular(AppRadii.card),
                      bottomRight: Radius.circular(AppRadii.card),
                    ),
                  ),
                  child: _MarkdownText(message.content),
                ),

                // Referenced ticket chips
                if (referencedTicketIds.isNotEmpty ||
                    referencedIssueIds.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        ...referencedTicketIds.map(
                          (id) => _LinkChip(
                            label: 'View ticket',
                            icon: Icons.confirmation_number,
                            onTap: () =>
                                context.push(RoutePaths.ticketDetail(id)),
                          ),
                        ),
                        ...referencedIssueIds.map(
                          (id) => _LinkChip(
                            label: 'View issue',
                            icon: Icons.warning,
                            onTap: () => context
                                .push(RoutePaths.ongoingIssueDetail(id)),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Action card
                if (action != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: _ActionCard(
                      action: action!,
                      onConfirm: onConfirm,
                      onReject: onReject,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Action card — confirm / reject
// ---------------------------------------------------------------------------

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.action,
    required this.onConfirm,
    required this.onReject,
  });

  final ZiaAction action;
  final void Function(ZiaAction) onConfirm;
  final void Function(ZiaAction) onReject;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final resolved = action.isConfirmed || action.isRejected;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(
          color: action.isConfirmed
              ? colors.success.withAlpha(80)
              : action.isRejected
                  ? colors.line
                  : Theme.of(context).colorScheme.primary.withAlpha(80),
        ),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action type label
          Row(
            children: [
              Icon(
                _actionIcon(action.type),
                size: 14,
                color: resolved
                    ? (action.isConfirmed ? colors.success : colors.textTertiary)
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                _actionTypeLabel(action.type),
                style: textTheme.labelSmall?.copyWith(
                  color: resolved
                      ? (action.isConfirmed
                          ? colors.success
                          : colors.textTertiary)
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (action.isConfirmed) ...[
                const Spacer(),
                Icon(Icons.check_circle,
                    size: 14, color: colors.success),
              ] else if (action.isRejected) ...[
                const Spacer(),
                Icon(Icons.close,
                    size: 14, color: colors.textTertiary),
              ],
            ],
          ),

          // Ticket subject / description
          if (action.ticketSubject != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              action.ticketSubject!,
              style: textTheme.bodySmall?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          // Status transition
          if (action.fromStatus != null && action.toStatus != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Text(action.fromStatus!.displayLabel,
                    style: textTheme.labelSmall
                        ?.copyWith(color: colors.textSecondary)),
                const ExcludeSemantics(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.arrow_forward, size: 12),
                  ),
                ),
                Text(action.toStatus!.displayLabel,
                    style: textTheme.labelSmall
                        ?.copyWith(color: colors.textSecondary)),
              ],
            ),
          ],

          // Priority transition
          if (action.fromPriority != null && action.toPriority != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Text(action.fromPriority!.displayLabel,
                    style: textTheme.labelSmall
                        ?.copyWith(color: colors.textSecondary)),
                const ExcludeSemantics(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.arrow_forward, size: 12),
                  ),
                ),
                Text(action.toPriority!.displayLabel,
                    style: textTheme.labelSmall
                        ?.copyWith(color: colors.textSecondary)),
              ],
            ),
          ],

          // Buttons
          if (!resolved) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => onConfirm(action),
                    child: Text(action.confirmLabel),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onReject(action),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              action.isConfirmed ? 'Completed' : 'Cancelled',
              style: textTheme.labelSmall?.copyWith(
                color: action.isConfirmed
                    ? colors.success
                    : colors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static IconData _actionIcon(ZiaActionType type) => switch (type) {
        ZiaActionType.changeStatus => Icons.refresh,
        ZiaActionType.changePriority => Icons.arrow_upward,
        ZiaActionType.addComment => Icons.chat,
        ZiaActionType.createTicket => Icons.add,
      };

  static String _actionTypeLabel(ZiaActionType type) => switch (type) {
        ZiaActionType.changeStatus => 'Change status',
        ZiaActionType.changePriority => 'Change priority',
        ZiaActionType.addComment => 'Add comment',
        ZiaActionType.createTicket => 'Create ticket',
      };
}

// ---------------------------------------------------------------------------
// Typing indicator
// ---------------------------------------------------------------------------

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      label: 'Zia is typing',
      liveRegion: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin, AppSpacing.xs,
          AppSpacing.xxxxl, AppSpacing.xs,
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(right: AppSpacing.xs),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.ziaGradientStart, colors.ziaGradientEnd],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.line),
                borderRadius: BorderRadius.circular(AppRadii.card),
              ),
              child: const ExcludeSemantics(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 2),
                    _Dot(delay: 0),
                    SizedBox(width: 4),
                    _Dot(delay: 150),
                    SizedBox(width: 4),
                    _Dot(delay: 300),
                    SizedBox(width: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  const _Dot({required this.delay});
  final int delay;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _anim = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: colors.textTertiary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Composer bar
// ---------------------------------------------------------------------------

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({
    required this.controller,
    required this.enabled,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool enabled;
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
                enabled: enabled,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: enabled ? (_) => onSend() : null,
                decoration: InputDecoration(
                  hintText: 'Ask Zia…',
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
              onPressed: enabled ? onSend : null,
              tooltip: 'Send',
              icon: const Icon(Icons.send, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error banner
// ---------------------------------------------------------------------------

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onDismiss});
  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.xs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.danger.withAlpha(20),
        border: Border.all(color: colors.danger.withAlpha(80)),
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Row(
        children: [
          Icon(Icons.error,
              size: 14, color: colors.danger),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: colors.danger),
            ),
          ),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close,
                size: 14, color: colors.danger),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Link chip (for referenced tickets / issues)
// ---------------------------------------------------------------------------

class _LinkChip extends StatelessWidget {
  const _LinkChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 12),
      label: Text(label),
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

// ---------------------------------------------------------------------------
// Simple bold-markdown renderer (handles **text** only)
// ---------------------------------------------------------------------------

class _MarkdownText extends StatelessWidget {
  const _MarkdownText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.of(context).textPrimary,
        );
    final boldStyle = baseStyle?.copyWith(fontWeight: FontWeight.w700);

    final spans = <TextSpan>[];
    final parts = text.split('**');
    for (var i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text: parts[i],
        style: i.isOdd ? boldStyle : baseStyle,
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
      overflow: TextOverflow.clip,
    );
  }
}
