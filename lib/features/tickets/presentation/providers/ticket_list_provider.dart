import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/features/authentication/presentation/providers/session_provider.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket.dart';
import 'package:zoho_support_hub/features/tickets/presentation/providers/ticket_filter_provider.dart';
import 'package:zoho_support_hub/shared/models/pagination.dart';

/// Paginated ticket list for the current account, re-evaluated on filter change.
final ticketListProvider = FutureProvider<PaginatedResult<Ticket>>((ref) async {
  final ctx = ref.watch(currentContextProvider);
  if (ctx == null) {
    return const PaginatedResult(items: [], totalCount: 0, page: 1, pageSize: 50);
  }
  final filter = ref.watch(ticketFilterProvider);
  return ref.read(ticketRepositoryProvider).listTickets(
        context: ctx,
        filter: filter,
        pageSize: 50,
      );
});
