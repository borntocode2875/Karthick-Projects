import 'package:flutter/foundation.dart';

/// A typed page of results returned by list endpoints.
@immutable
class PaginatedResult<T> {
  const PaginatedResult({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<T> items;
  final int totalCount;
  final int page;
  final int pageSize;

  bool get hasMore => page * pageSize < totalCount;
  int get totalPages => (totalCount / pageSize).ceil();

  PaginatedResult<T> copyWith({
    List<T>? items,
    int? totalCount,
    int? page,
    int? pageSize,
  }) {
    return PaginatedResult<T>(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
