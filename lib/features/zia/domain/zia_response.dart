import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_action.dart';

part 'zia_response.freezed.dart';

/// The result returned by [ZiaRepository.sendMessage].
@freezed
abstract class ZiaResponse with _$ZiaResponse {
  const factory ZiaResponse({
    required String messageId,
    required String text,
    /// A proposed action, present when Zia wants the user to confirm something.
    ZiaAction? proposedAction,
    /// Ticket IDs referenced in the response, for quick navigation.
    @Default([]) List<String> referencedTicketIds,
    /// Issue IDs referenced in the response.
    @Default([]) List<String> referencedIssueIds,
  }) = _ZiaResponse;
}
