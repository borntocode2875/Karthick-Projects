import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/utils/mock_latency.dart';
import 'package:zoho_support_hub/features/accounts/data/mock_data.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue_repository.dart';

class MockOngoingIssueRepository implements OngoingIssueRepository {
  @override
  Future<List<OngoingIssue>> listIssues({
    DataCenter? dataCenter,
    String? product,
  }) async {
    await mockDelay();
    var issues = List.of(mockOngoingIssues);

    if (dataCenter != null) {
      issues = issues
          .where((i) => i.affectedDataCenters.contains(dataCenter))
          .toList();
    }
    if (product != null) {
      issues = issues
          .where((i) => i.affectedProducts
              .any((p) => p.toLowerCase().contains(product.toLowerCase())))
          .toList();
    }

    // Active/investigating first, then scheduled, then resolved.
    issues.sort((a, b) {
      int rank(OngoingIssue i) {
        if (i.isActive) return 0;
        if (i.isScheduled) return 1;
        return 2;
      }
      final r = rank(a).compareTo(rank(b));
      if (r != 0) return r;
      return b.updatedAt.compareTo(a.updatedAt);
    });

    return issues;
  }

  @override
  Future<OngoingIssue> getIssue(String issueId) async {
    await mockDelay();
    return mockOngoingIssues.firstWhere(
      (i) => i.id == issueId,
      orElse: () => throw const NotFoundError('Issue not found.'),
    );
  }
}
