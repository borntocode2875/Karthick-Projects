import 'package:dio/dio.dart';
import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue_repository.dart';

/// Fetches Zoho service status from the public Zoho Status API.
/// No authentication required — status is public.
class ZohoOngoingIssueRepository implements OngoingIssueRepository {
  ZohoOngoingIssueRepository()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://status.zoho.com/api/v1/',
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );

  final Dio _dio;

  @override
  Future<List<OngoingIssue>> listIssues({
    DataCenter? dataCenter,
    String? product,
  }) async {
    try {
      final resp = await _dio.get<Map<String, dynamic>>('incidents');
      final body = resp.data as Map<String, dynamic>;
      final incidents = (body['incidents'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      final maintenances = (body['scheduledMaintenances'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();

      var issues = [
        ...incidents.map((j) => _issueFromJson(j, isScheduled: false)),
        ...maintenances.map((j) => _issueFromJson(j, isScheduled: true)),
      ];

      if (dataCenter != null) {
        issues = issues
            .where((i) =>
                i.affectedDataCenters.isEmpty ||
                i.affectedDataCenters.contains(dataCenter))
            .toList();
      }
      if (product != null) {
        issues = issues
            .where((i) =>
                i.affectedProducts.isEmpty ||
                i.affectedProducts.any(
                  (p) => p.toLowerCase().contains(product.toLowerCase()),
                ))
            .toList();
      }

      issues.sort((a, b) {
        final aOrder = _statusOrder(a.status);
        final bOrder = _statusOrder(b.status);
        if (aOrder != bOrder) return aOrder.compareTo(bOrder);
        return b.updatedAt.compareTo(a.updatedAt);
      });

      return issues;
    } on DioException catch (e) {
      throw NetworkError(e.message ?? 'Could not fetch status.');
    }
  }

  @override
  Future<OngoingIssue> getIssue(String issueId) async {
    try {
      final resp = await _dio.get<Map<String, dynamic>>('incidents/$issueId');
      return _issueFromJson(resp.data as Map<String, dynamic>, isScheduled: false);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) throw const NotFoundError();
      throw NetworkError(e.message ?? 'Could not fetch issue.');
    }
  }

  // ---------------------------------------------------------------------------

  OngoingIssue _issueFromJson(Map<String, dynamic> j, {required bool isScheduled}) {
    final statusStr = j['status'] as String? ?? '';
    final status = isScheduled ? IssueStatus.scheduled : _parseStatus(statusStr);
    final components = (j['components'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final updates = (j['incident_updates'] ?? j['postmortem_body']) is List
        ? (j['incident_updates'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(_updateFromJson)
            .toList()
        : <IssueUpdate>[];

    return OngoingIssue(
      id: j['id']?.toString() ?? '',
      title: j['name'] as String? ?? '',
      description: (updates.isNotEmpty ? updates.last.content : j['body'] as String?) ?? '',
      status: status,
      severity: _parseSeverity(j['impact'] as String? ?? ''),
      affectedProducts: components.map((c) => c['name'] as String? ?? '').where((s) => s.isNotEmpty).toList(),
      affectedDataCenters: const [],
      startedAt: _parseDate(j['created_at'] as String?),
      resolvedAt: status == IssueStatus.resolved ? _parseDate(j['resolved_at'] as String?) : null,
      scheduledFor: isScheduled ? _parseDate(j['scheduled_for'] as String?) : null,
      updatedAt: _parseDate(j['updated_at'] as String?),
      timeline: updates,
    );
  }

  IssueUpdate _updateFromJson(Map<String, dynamic> j) {
    return IssueUpdate(
      id: j['id']?.toString() ?? '',
      content: j['body'] as String? ?? '',
      status: _parseStatus(j['status'] as String? ?? ''),
      timestamp: _parseDate(j['created_at'] as String?),
    );
  }

  static IssueStatus _parseStatus(String s) {
    switch (s.toLowerCase()) {
      case 'investigating':
        return IssueStatus.investigating;
      case 'resolved':
      case 'postmortem':
        return IssueStatus.resolved;
      case 'scheduled':
        return IssueStatus.scheduled;
      default:
        return IssueStatus.active;
    }
  }

  static IssueSeverity _parseSeverity(String s) {
    switch (s.toLowerCase()) {
      case 'critical':
        return IssueSeverity.critical;
      case 'major':
        return IssueSeverity.high;
      case 'minor':
        return IssueSeverity.medium;
      default:
        return IssueSeverity.low;
    }
  }

  static int _statusOrder(IssueStatus s) => switch (s) {
        IssueStatus.active => 0,
        IssueStatus.investigating => 1,
        IssueStatus.scheduled => 2,
        IssueStatus.resolved => 3,
      };

  static DateTime _parseDate(String? s) {
    if (s == null) return DateTime.now();
    try {
      return DateTime.parse(s);
    } catch (_) {
      return DateTime.now();
    }
  }
}
