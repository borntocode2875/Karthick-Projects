import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

part 'ticket_filter.freezed.dart';

enum TicketSortField { createdAt, updatedAt, priority, status }

enum SortDirection { asc, desc }

@freezed
abstract class TicketFilter with _$TicketFilter {
  const factory TicketFilter({
    @Default([]) List<TicketStatus> statuses,
    @Default([]) List<TicketPriority> priorities,
    String? product,
    String? category,
    String? searchQuery,
    @Default(TicketSortField.updatedAt) TicketSortField sortField,
    @Default(SortDirection.desc) SortDirection sortDirection,
  }) = _TicketFilter;

  const TicketFilter._();

  bool get isEmpty =>
      statuses.isEmpty &&
      priorities.isEmpty &&
      product == null &&
      category == null &&
      (searchQuery == null || searchQuery!.isEmpty);
}
