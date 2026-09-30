import 'package:freezed_annotation/freezed_annotation.dart';

part 'zia_chat_message.freezed.dart';

enum ZiaMessageRole { user, zia }

@freezed
abstract class ZiaChatMessage with _$ZiaChatMessage {
  const factory ZiaChatMessage({
    required String id,
    required ZiaMessageRole role,
    required String content,
    required DateTime timestamp,
    /// Proposed action attached to this message, if any.
    String? actionId,
  }) = _ZiaChatMessage;
}
