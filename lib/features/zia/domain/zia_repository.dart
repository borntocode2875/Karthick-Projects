import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_action.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_chat_message.dart';
import 'package:zoho_support_hub/features/zia/domain/zia_response.dart';

/// Interface for Zia AI interactions.
///
/// Phase 1: deterministic keyword/intent matching in [MockZiaRepository].
/// Phase 2: drop in a live LLM backend without changing any screen code.
///
/// Security: Zia output is untrusted. Prompt-injection attempts (instructions
/// in ticket content or user messages that try to change permissions or act
/// as admin) must be rejected by the repository, not the UI.
abstract class ZiaRepository {
  /// Sends a user message and returns Zia's response.
  ///
  /// [history] is the conversation so far, oldest first.
  /// Throws [AuthorizationError] for injection attempts or out-of-scope requests.
  Future<ZiaResponse> sendMessage({
    required AccountContext context,
    required String message,
    required List<ZiaChatMessage> history,
  });

  /// Executes a confirmed [action] through the appropriate repository.
  ///
  /// The action must have been proposed by [sendMessage] and confirmed by the
  /// user. Throws [AuthorizationError] if the action is no longer valid.
  Future<ZiaAction> confirmAction({
    required AccountContext context,
    required ZiaAction action,
  });

  /// Explicitly cancels / rejects a proposed action.
  Future<ZiaAction> rejectAction({
    required AccountContext context,
    required ZiaAction action,
  });
}
