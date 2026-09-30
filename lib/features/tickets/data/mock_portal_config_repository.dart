import 'package:zoho_support_hub/core/errors/app_error.dart';
import 'package:zoho_support_hub/core/utils/mock_latency.dart';
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/tickets/domain/dynamic_field.dart';
import 'package:zoho_support_hub/features/tickets/domain/portal_configuration.dart';
import 'package:zoho_support_hub/features/tickets/domain/portal_configuration_repository.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

class MockPortalConfigurationRepository implements PortalConfigurationRepository {
  static const Map<String, PortalConfiguration> _configs = {
    // Portal A — Northwind Traders
    'portal-a': PortalConfiguration(
      portalId: 'portal-a',
      portalName: 'Northwind Support',
      accountId: 'account-a',
      createTicketFields: [
        SingleSelectDynamicField(
          key: 'region',
          label: 'Region',
          choices: ['North', 'South', 'East', 'West'],
          isRequired: true,
        ),
        TextDynamicField(
          key: 'invoice_number',
          label: 'Invoice Number',
          placeholder: 'e.g. INV-2024-0001',
        ),
        NumberDynamicField(
          key: 'affected_users',
          label: 'Affected Users',
          minValue: 1,
          maxValue: 10000,
        ),
      ],
      filterFields: [
        SingleSelectDynamicField(
          key: 'region',
          label: 'Region',
          choices: ['North', 'South', 'East', 'West'],
        ),
      ],
      availableStatuses: [
        TicketStatus.open,
        TicketStatus.inProgress,
        TicketStatus.onHold,
        TicketStatus.resolved,
        TicketStatus.closed,
      ],
      availablePriorities: TicketPriority.values,
      products: ['Zoho CRM', 'Zoho Books', 'Zoho Desk'],
      categories: {
        'Zoho CRM': ['Data Sync', 'Import', 'Reports', 'Integrations', 'Other'],
        'Zoho Books': ['Reports', 'Invoicing', 'GST', 'Payroll', 'Other'],
        'Zoho Desk': ['Widget', 'Notifications', 'Attachments', 'Access', 'Other'],
      },
      attachmentConfig: AttachmentConfig(
        maxFileSizeBytes: 20 * 1024 * 1024,
        maxFiles: 10,
      ),
      defaultPermissions: TicketPermissions(),
    ),

    // Portal B — Brightline Analytics (customers cannot change priority)
    'portal-b': PortalConfiguration(
      portalId: 'portal-b',
      portalName: 'Brightline Support',
      accountId: 'account-b',
      createTicketFields: [
        SingleSelectDynamicField(
          key: 'environment',
          label: 'Environment',
          choices: ['Production', 'Staging', 'Development'],
          isRequired: true,
        ),
        TextDynamicField(
          key: 'workspace_url',
          label: 'Workspace URL',
          placeholder: 'https://analytics.yourcompany.com/...',
        ),
        LongTextDynamicField(
          key: 'business_impact',
          label: 'Business Impact',
          isRequired: true,
          maxLength: 1000,
        ),
        BooleanDynamicField(
          key: 'reproducible',
          label: 'Can you reproduce this consistently?',
        ),
      ],
      filterFields: [
        SingleSelectDynamicField(
          key: 'environment',
          label: 'Environment',
          choices: ['Production', 'Staging', 'Development'],
        ),
      ],
      availableStatuses: [
        TicketStatus.open,
        TicketStatus.inProgress,
        TicketStatus.onHold,
        TicketStatus.resolved,
        TicketStatus.closed,
      ],
      availablePriorities: TicketPriority.values,
      products: ['Zoho Analytics', 'Zoho Creator'],
      categories: {
        'Zoho Analytics': ['Dashboards', 'Reports', 'Authentication', 'Webhooks', 'Other'],
        'Zoho Creator': ['Webhooks', 'Forms', 'Workflows', 'Access', 'Other'],
      },
      attachmentConfig: AttachmentConfig(
        maxFileSizeBytes: 50 * 1024 * 1024,
        maxFiles: 5,
      ),
      defaultPermissions: TicketPermissions(canChangePriority: false),
    ),

    // Portal C — Harbor Health Clinics
    'portal-c': PortalConfiguration(
      portalId: 'portal-c',
      portalName: 'Harbor Health Support',
      accountId: 'account-c',
      createTicketFields: [
        MultiSelectDynamicField(
          key: 'affected_departments',
          label: 'Affected Departments',
          choices: [
            'Cardiology',
            'Orthopaedics',
            'Pathology',
            'Radiology',
            'General Medicine',
            'Administration',
          ],
          isRequired: true,
        ),
      ],
      filterFields: [
        MultiSelectDynamicField(
          key: 'affected_departments',
          label: 'Department',
          choices: [
            'Cardiology',
            'Orthopaedics',
            'Pathology',
            'Radiology',
            'General Medicine',
            'Administration',
          ],
        ),
      ],
      availableStatuses: [
        TicketStatus.open,
        TicketStatus.inProgress,
        TicketStatus.resolved,
        TicketStatus.closed,
      ],
      availablePriorities: TicketPriority.values,
      products: ['Zoho Desk'],
      categories: {
        'Zoho Desk': ['Notifications', 'Attachments', 'Access', 'Appointments', 'Other'],
      },
      // Attachments limited to images and PDF.
      attachmentConfig: AttachmentConfig(
        allowedMimeTypes: [
          'image/jpeg',
          'image/png',
          'image/webp',
          'application/pdf',
        ],
        allowedExtensions: ['.jpg', '.jpeg', '.png', '.webp', '.pdf'],
        maxFileSizeBytes: 10 * 1024 * 1024,
        maxFiles: 5,
      ),
      defaultPermissions: TicketPermissions(),
    ),
  };

  @override
  Future<PortalConfiguration> getConfiguration(AccountContext context) async {
    await mockDelay();
    final config = _configs[context.portalId];
    if (config == null || config.accountId != context.accountId) {
      throw const AuthorizationError();
    }
    return config;
  }
}
