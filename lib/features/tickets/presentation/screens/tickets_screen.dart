import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zoho_support_hub/app/router/app_shell.dart';
import 'package:zoho_support_hub/app/router/routes.dart';
import 'package:zoho_support_hub/app/theme/app_colors.dart';
import 'package:zoho_support_hub/app/theme/app_spacing.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_filter.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/portal_config_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/ticket_filter_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/ticket_list_provider.dart';
import 'package:zoho_support_hub/features/tickets/presentation/widgets/ticket_card.dart';
import 'package:zoho_support_hub/features/tickets/presentation/widgets/ticket_status_badge.dart';

class TicketsScreen extends ConsumerStatefulWidget {
  const TicketsScreen({super.key});

  @override
  ConsumerState<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends ConsumerState<TicketsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final filter = ref.watch(ticketFilterProvider);
    final tickets = ref.watch(ticketListProvider);
    final ctx = ref.watch(currentContextProvider);

    return TabScaffold(
      title: 'Tickets',
      actions: [
        IconButton(
          icon: Icon(
            Icons.filter_list,
            color: filter.isEmpty
                ? colors.textSecondary
                : Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => _showFilterSheet(context),
          tooltip: 'Filter',
        ),
      ],
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.sm,
              AppSpacing.screenMargin, 0,
            ),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search tickets…',
              leading: Icon(Icons.search,
                  color: colors.textSecondary, size: 18),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.close,
                        color: colors.textSecondary, size: 16),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(ticketFilterProvider.notifier).setSearch(null);
                    },
                  ),
              ],
              onChanged: (q) =>
                  ref.read(ticketFilterProvider.notifier).setSearch(q),
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor:
                  WidgetStatePropertyAll(colors.surface),
              side: WidgetStatePropertyAll(
                BorderSide(color: colors.line),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.chip),
                ),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: AppSpacing.md),
              ),
            ),
          ),

          // Active filter chips row
          if (!filter.isEmpty)
            _ActiveFilterChips(
              filter: filter,
              onClear: () {
                _searchController.clear();
                ref.read(ticketFilterProvider.notifier).reset();
              },
            ),

          const SizedBox(height: AppSpacing.xs),

          // Ticket list
          Expanded(
            child: tickets.when(
              data: (result) {
                if (result.items.isEmpty) {
                  return _EmptyState(
                    hasFilter: !filter.isEmpty,
                    onClear: () {
                      _searchController.clear();
                      ref.read(ticketFilterProvider.notifier).reset();
                    },
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async =>
                      ref.refresh(ticketListProvider.future),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        bottom: AppSpacing.xxxxl + AppSpacing.xl),
                    itemCount: result.items.length,
                    itemBuilder: (_, i) {
                      final t = result.items[i];
                      return TicketCard(
                        ticket: t,
                        onTap: () =>
                            context.push(RoutePaths.ticketDetail(t.id)),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => _ErrorState(
                message: e.toString(),
                onRetry: () => ref.refresh(ticketListProvider.future),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ctx != null
          ? FloatingActionButton(
              onPressed: () => context.push(RoutePaths.createTicket),
              tooltip: 'New ticket',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showFilterSheet(BuildContext context) {
    final portalConfig = ref.read(portalConfigProvider);
    final availableStatuses = portalConfig.valueOrNull?.availableStatuses ??
        TicketStatus.values;
    final availablePriorities =
        portalConfig.valueOrNull?.availablePriorities ?? TicketPriority.values;
    final products = portalConfig.valueOrNull?.products ?? const [];

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _FilterSheet(
        availableStatuses: availableStatuses,
        availablePriorities: availablePriorities,
        products: products,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filter sheet
// ---------------------------------------------------------------------------

class _FilterSheet extends ConsumerWidget {
  const _FilterSheet({
    required this.availableStatuses,
    required this.availablePriorities,
    required this.products,
  });

  final List<TicketStatus> availableStatuses;
  final List<TicketPriority> availablePriorities;
  final List<String> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final filter = ref.watch(ticketFilterProvider);
    final notifier = ref.read(ticketFilterProvider.notifier);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => Column(
        children: [
          // Handle + header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.sm,
              AppSpacing.screenMargin, 0,
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 32, height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: colors.line,
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text('Filters',
                        style: textTheme.titleMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        notifier.clearFilters();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Clear all'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              children: [
                // Status
                _FilterSection(
                  title: 'Status',
                  children: availableStatuses.map((s) {
                    final sel = filter.statuses.contains(s);
                    return FilterChip(
                      label: Text(s.displayLabel),
                      selected: sel,
                      onSelected: (_) => notifier.toggleStatus(s),
                      avatar: TicketStatusBadge(s, small: true),
                      showCheckmark: false,
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.base),

                // Priority
                _FilterSection(
                  title: 'Priority',
                  children: availablePriorities.map((p) {
                    final sel = filter.priorities.contains(p);
                    return FilterChip(
                      label: Text(p.displayLabel),
                      selected: sel,
                      onSelected: (_) => notifier.togglePriority(p),
                      avatar: PriorityIndicator(p.barCount, size: 12),
                      showCheckmark: false,
                    );
                  }).toList(),
                ),

                if (products.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.base),
                  _FilterSection(
                    title: 'Product',
                    children: products.map((p) {
                      final sel = filter.product == p;
                      return FilterChip(
                        label: Text(p),
                        selected: sel,
                        onSelected: (_) =>
                            notifier.setProduct(sel ? null : p),
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: AppSpacing.base),

                // Sort
                _FilterSection(
                  title: 'Sort by',
                  children: TicketSortField.values.map((f) {
                    final sel = filter.sortField == f;
                    return FilterChip(
                      label: Text(_sortLabel(f)),
                      selected: sel,
                      onSelected: sel
                          ? (_) => notifier.toggleSortDirection()
                          : (_) => notifier.setSortField(f),
                      avatar: sel
                          ? Icon(
                              filter.sortDirection == SortDirection.desc
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              size: 14,
                            )
                          : null,
                      showCheckmark: false,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Apply'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _sortLabel(TicketSortField f) => switch (f) {
        TicketSortField.updatedAt => 'Last updated',
        TicketSortField.createdAt => 'Created',
        TicketSortField.priority => 'Priority',
        TicketSortField.status => 'Status',
      };
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                )),
        const SizedBox(height: AppSpacing.sm),
        Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.xs,
            children: children),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Active filter chips (below search bar)
// ---------------------------------------------------------------------------

class _ActiveFilterChips extends ConsumerWidget {
  const _ActiveFilterChips({required this.filter, required this.onClear});
  final TicketFilter filter;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(ticketFilterProvider.notifier);
    final chips = <Widget>[];

    for (final s in filter.statuses) {
      chips.add(_DismissChip(
        label: s.displayLabel,
        onDismiss: () => notifier.toggleStatus(s),
      ));
    }
    for (final p in filter.priorities) {
      chips.add(_DismissChip(
        label: p.displayLabel,
        onDismiss: () => notifier.togglePriority(p),
      ));
    }
    if (filter.product != null) {
      chips.add(_DismissChip(
        label: filter.product!,
        onDismiss: () => notifier.setProduct(null),
      ));
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenMargin, vertical: AppSpacing.xs),
        children: chips,
      ),
    );
  }
}

class _DismissChip extends StatelessWidget {
  const _DismissChip({required this.label, required this.onDismiss});
  final String label;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: InputChip(
        label: Text(label),
        onDeleted: onDismiss,
        deleteIconColor: AppColors.of(context).textSecondary,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty / error states
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasFilter, required this.onClear});
  final bool hasFilter;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.confirmation_number,
                size: 48, color: colors.textTertiary),
            const SizedBox(height: AppSpacing.base),
            Text(
              hasFilter ? 'No tickets match your filters.' : 'No tickets yet.',
              style:
                  textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (hasFilter) ...[
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: onClear,
                child: const Text('Clear filters'),
              ),
            ],
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
            Icon(Icons.error,
                size: 40, color: colors.danger),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Could not load tickets.',
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
