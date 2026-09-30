import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';

part 'ongoing_issue.freezed.dart';

enum IssueStatus { active, investigating, resolved, scheduled }

enum IssueSeverity { low, medium, high, critical }

@freezed
abstract class IssueUpdate with _$IssueUpdate {
  const factory IssueUpdate({
    required String id,
    required String content,
    required IssueStatus status,
    required DateTime timestamp,
  }) = _IssueUpdate;
}

@freezed
abstract class OngoingIssue with _$OngoingIssue {
  const factory OngoingIssue({
    required String id,
    required String title,
    required String description,
    required IssueStatus status,
    required IssueSeverity severity,
    required List<String> affectedProducts,
    required List<DataCenter> affectedDataCenters,
    required DateTime startedAt,
    DateTime? resolvedAt,
    DateTime? scheduledFor,
    required DateTime updatedAt,
    @Default([]) List<IssueUpdate> timeline,
  }) = _OngoingIssue;

  const OngoingIssue._();

  bool get isActive => status == IssueStatus.active || status == IssueStatus.investigating;
  bool get isResolved => status == IssueStatus.resolved;
  bool get isScheduled => status == IssueStatus.scheduled;
}
