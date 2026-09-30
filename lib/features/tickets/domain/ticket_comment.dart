import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_comment.freezed.dart';

enum CommentAuthorType { customer, agent }

@freezed
abstract class TicketComment with _$TicketComment {
  const factory TicketComment({
    required String id,
    required String ticketId,
    required String content,
    required String authorName,
    required CommentAuthorType authorType,
    required DateTime createdAt,
    @Default([]) List<String> attachmentIds,
    @Default(false) bool isPublic,
  }) = _TicketComment;
}
