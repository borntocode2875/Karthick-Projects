import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_attachment.freezed.dart';

@freezed
abstract class TicketAttachment with _$TicketAttachment {
  const factory TicketAttachment({
    required String id,
    required String name,
    required String mimeType,
    required int sizeBytes,
    required String downloadUrl,
    required DateTime uploadedAt,
  }) = _TicketAttachment;
}
