import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue.dart';

abstract class OngoingIssueRepository {
  /// Returns all known issues, optionally filtered by [dataCenter] and/or [product].
  ///
  /// Results are ordered: active/investigating first, then scheduled, then resolved.
  Future<List<OngoingIssue>> listIssues({
    DataCenter? dataCenter,
    String? product,
  });

  /// Fetches a single issue by [issueId] with full timeline.
  Future<OngoingIssue> getIssue(String issueId);
}
