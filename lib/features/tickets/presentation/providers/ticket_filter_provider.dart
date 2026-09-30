import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_filter.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

class TicketFilterNotifier extends StateNotifier<TicketFilter> {
  TicketFilterNotifier() : super(const TicketFilter());

  void setSearch(String? q) =>
      state = state.copyWith(searchQuery: q?.isEmpty == true ? null : q);

  void toggleStatus(TicketStatus s) {
    final list = List<TicketStatus>.of(state.statuses);
    list.contains(s) ? list.remove(s) : list.add(s);
    state = state.copyWith(statuses: list);
  }

  void togglePriority(TicketPriority p) {
    final list = List<TicketPriority>.of(state.priorities);
    list.contains(p) ? list.remove(p) : list.add(p);
    state = state.copyWith(priorities: list);
  }

  void setProduct(String? product) =>
      state = state.copyWith(product: product, category: null);

  void setCategory(String? category) =>
      state = state.copyWith(category: category);

  void setSortField(TicketSortField field) =>
      state = state.copyWith(sortField: field);

  void toggleSortDirection() => state = state.copyWith(
        sortDirection: state.sortDirection == SortDirection.desc
            ? SortDirection.asc
            : SortDirection.desc,
      );

  void clearFilters() => state = state.copyWith(
        statuses: const [],
        priorities: const [],
        product: null,
        category: null,
      );

  void reset() => state = const TicketFilter();
}

final ticketFilterProvider =
    StateNotifierProvider<TicketFilterNotifier, TicketFilter>(
  (ref) => TicketFilterNotifier(),
);
