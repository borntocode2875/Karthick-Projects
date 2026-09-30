import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoho_support_hub/app/config/repository_providers.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue.dart';

// ---------------------------------------------------------------------------
// Filter
// ---------------------------------------------------------------------------

class OngoingIssueFilter {
  const OngoingIssueFilter({this.dataCenter, this.product});

  final DataCenter? dataCenter;
  final String? product;

  bool get isEmpty => dataCenter == null && product == null;

  OngoingIssueFilter copyWith({
    Object? dataCenter = _sentinel,
    Object? product = _sentinel,
  }) {
    return OngoingIssueFilter(
      dataCenter: dataCenter == _sentinel
          ? this.dataCenter
          : dataCenter as DataCenter?,
      product: product == _sentinel ? this.product : product as String?,
    );
  }
}

const _sentinel = Object();

class OngoingIssueFilterNotifier
    extends StateNotifier<OngoingIssueFilter> {
  OngoingIssueFilterNotifier() : super(const OngoingIssueFilter());

  void setDataCenter(DataCenter? dc) =>
      state = state.copyWith(dataCenter: dc);

  void setProduct(String? p) => state = state.copyWith(product: p);

  void reset() => state = const OngoingIssueFilter();
}

final ongoingIssueFilterProvider =
    StateNotifierProvider<OngoingIssueFilterNotifier, OngoingIssueFilter>(
  (ref) => OngoingIssueFilterNotifier(),
);

// ---------------------------------------------------------------------------
// Issue list
// ---------------------------------------------------------------------------

final ongoingIssueListProvider =
    FutureProvider<List<OngoingIssue>>((ref) async {
  final filter = ref.watch(ongoingIssueFilterProvider);
  return ref.read(ongoingIssueRepositoryProvider).listIssues(
        dataCenter: filter.dataCenter,
        product: filter.product,
      );
});

// ---------------------------------------------------------------------------
// Issue detail
// ---------------------------------------------------------------------------

final ongoingIssueDetailProvider =
    FutureProvider.autoDispose.family<OngoingIssue, String>(
  (ref, id) => ref.read(ongoingIssueRepositoryProvider).getIssue(id),
);
