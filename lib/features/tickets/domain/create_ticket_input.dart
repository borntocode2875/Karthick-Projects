import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';

part 'create_ticket_input.freezed.dart';

@freezed
abstract class CreateTicketInput with _$CreateTicketInput {
  const factory CreateTicketInput({
    required String subject,
    required String description,
    required TicketPriority priority,
    String? product,
    String? category,
    String? subCategory,
    /// Portal-specific custom field values, keyed by field key.
    @Default({}) Map<String, Object?> customFieldValues,
    @Default([]) List<String> attachmentIds,
  }) = _CreateTicketInput;
}
