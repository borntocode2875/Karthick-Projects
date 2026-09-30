import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/tickets/domain/dynamic_field.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

part 'portal_configuration.freezed.dart';

/// Attachment constraints for a portal.
@freezed
abstract class AttachmentConfig with _$AttachmentConfig {
  const factory AttachmentConfig({
    /// Allowed MIME types. Empty = all types allowed.
    @Default([]) List<String> allowedMimeTypes,
    /// Allowed file extensions (e.g. ['.pdf', '.jpg']). Empty = all allowed.
    @Default([]) List<String> allowedExtensions,
    /// Max size per file in bytes. Null = no limit.
    int? maxFileSizeBytes,
    /// Max total number of attachments per ticket. Null = no limit.
    int? maxFiles,
  }) = _AttachmentConfig;
}

/// Everything the app needs to know about a portal to render tickets correctly.
///
/// Nothing about ticket fields is hardcoded; this config drives the UI.
@freezed
abstract class PortalConfiguration with _$PortalConfiguration {
  const factory PortalConfiguration({
    required String portalId,
    required String portalName,
    required String accountId,
    /// Fields shown on the create-ticket form.
    required List<DynamicField> createTicketFields,
    /// Fields available as list filters (subset of createTicketFields + standard).
    required List<DynamicField> filterFields,
    required List<TicketStatus> availableStatuses,
    required List<TicketPriority> availablePriorities,
    required List<String> products,
    /// product name → list of category names.
    @Default({}) Map<String, List<String>> categories,
    required AttachmentConfig attachmentConfig,
    required TicketPermissions defaultPermissions,
  }) = _PortalConfiguration;
}
