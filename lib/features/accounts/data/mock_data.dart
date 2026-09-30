// ignore_for_file: avoid_print
import 'package:zoho_support_hub/features/accounts/domain/account_context.dart';
import 'package:zoho_support_hub/features/accounts/domain/data_center.dart';
import 'package:zoho_support_hub/features/accounts/domain/desk_account.dart';
import 'package:zoho_support_hub/features/accounts/domain/ticket_permissions.dart';
import 'package:zoho_support_hub/features/accounts/domain/user_profile.dart';
import 'package:zoho_support_hub/features/notifications/domain/notification_item.dart';
import 'package:zoho_support_hub/features/ongoing_issues/domain/ongoing_issue.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_priority.dart';
import 'package:zoho_support_hub/features/tickets/domain/ticket_status.dart';

// ---------------------------------------------------------------------------
// Users
// ---------------------------------------------------------------------------

/// The primary demo customer — Alice Johnson.
const mockUserAlice = UserProfile(
  id: 'user-alice',
  name: 'Alice Johnson',
  email: 'alice@example.com',
  contactId: 'contact-alice',
);

/// Other customer in Portal A — must never be accessible by Alice.
const mockUserBob = UserProfile(
  id: 'user-bob',
  name: 'Bob Smith',
  email: 'bob@northwind.com',
  contactId: 'contact-bob',
);

/// Other customer in Portal B.
const mockUserCarol = UserProfile(
  id: 'user-carol',
  name: 'Carol Davis',
  email: 'carol@brightline.com',
  contactId: 'contact-carol',
);

/// Other customer in Portal C.
const mockUserDave = UserProfile(
  id: 'user-dave',
  name: 'Dave Wilson',
  email: 'dave@harborhealth.com',
  contactId: 'contact-dave',
);

// ---------------------------------------------------------------------------
// Accounts (DeskAccount)
// ---------------------------------------------------------------------------

/// Portal A — Northwind Traders, India DC.
const mockAccountA = DeskAccount(
  id: 'account-a',
  orgName: 'Northwind Traders',
  orgId: 'org-northwind',
  dataCenter: DataCenter.india,
  apiDomain: 'desk.zoho.in',
  portalId: 'portal-a',
  portalName: 'Northwind Support',
  avatarColor: '#2F5BEA',
  avatarInitial: 'N',
);

/// Portal B — Brightline Analytics, US DC.
const mockAccountB = DeskAccount(
  id: 'account-b',
  orgName: 'Brightline Analytics',
  orgId: 'org-brightline',
  dataCenter: DataCenter.us,
  apiDomain: 'desk.zoho.com',
  portalId: 'portal-b',
  portalName: 'Brightline Support',
  avatarColor: '#6D4AE0',
  avatarInitial: 'B',
);

/// Portal C — Harbor Health Clinics, India DC.
const mockAccountC = DeskAccount(
  id: 'account-c',
  orgName: 'Harbor Health Clinics',
  orgId: 'org-harbor',
  dataCenter: DataCenter.india,
  apiDomain: 'desk.zoho.in',
  portalId: 'portal-c',
  portalName: 'Harbor Health Support',
  avatarColor: '#0F7B6C',
  avatarInitial: 'H',
);

final mockAccounts = [mockAccountA, mockAccountB, mockAccountC];

// ---------------------------------------------------------------------------
// Account contexts
// ---------------------------------------------------------------------------

/// Alice's context for Portal A (full permissions).
const mockContextA = AccountContext(
  user: mockUserAlice,
  account: mockAccountA,
  permissions: TicketPermissions(),
);

/// Alice's context for Portal B (cannot change priority — per spec).
const mockContextB = AccountContext(
  user: mockUserAlice,
  account: mockAccountB,
  permissions: TicketPermissions(canChangePriority: false),
);

/// Alice's context for Portal C (full permissions).
const mockContextC = AccountContext(
  user: mockUserAlice,
  account: mockAccountC,
  permissions: TicketPermissions(),
);

// ---------------------------------------------------------------------------
// Tickets — Portal A (Northwind Traders, India DC)
// ---------------------------------------------------------------------------

final _baseA = DateTime(2024, 11, 1);

final mockTicketsA = <Ticket>[
  Ticket(
    id: 'ticket-a1',
    ticketNumber: '48213',
    subject: 'CRM records not syncing to Books',
    description:
        'Since the last update on 28-Oct, our CRM contacts are no longer syncing automatically to Zoho Books. '
        'This is affecting our invoicing workflow. Approx 5 users impacted.',
    status: TicketStatus.open,
    priority: TicketPriority.high,
    accountId: 'account-a',
    portalId: 'portal-a',
    dataCenter: DataCenter.india,
    contactId: 'contact-alice',
    contactName: 'Alice Johnson',
    contactEmail: 'alice@example.com',
    createdAt: _baseA.subtract(const Duration(days: 5)),
    updatedAt: _baseA.subtract(const Duration(days: 1)),
    commentCount: 2,
    hasUnread: true,
    customFieldValues: const {
      'region': 'South',
      'invoice_number': 'INV-2024-1089',
      'affected_users': 5,
    },
    product: 'Zoho CRM',
    category: 'Data Sync',
  ),
  Ticket(
    id: 'ticket-a2',
    ticketNumber: '48301',
    subject: 'Unable to generate GST report in Zoho Books',
    description:
        'The GST reconciliation report is throwing a "Data unavailable" error. '
        'This affects our monthly compliance filing. Tried clearing cache — no effect.',
    status: TicketStatus.inProgress,
    priority: TicketPriority.urgent,
    accountId: 'account-a',
    portalId: 'portal-a',
    dataCenter: DataCenter.india,
    contactId: 'contact-alice',
    contactName: 'Alice Johnson',
    contactEmail: 'alice@example.com',
    createdAt: _baseA.subtract(const Duration(days: 2)),
    updatedAt: _baseA,
    commentCount: 5,
    attachmentCount: 1,
    hasUnread: false,
    customFieldValues: const {
      'region': 'North',
      'invoice_number': 'GST-OCT-2024',
      'affected_users': 3,
    },
    product: 'Zoho Books',
    category: 'Reports',
  ),
  Ticket(
    id: 'ticket-a3',
    ticketNumber: '48099',
    subject: 'Zoho Desk widget not loading on website',
    description: 'The embedded Desk widget is showing a blank screen on our support page.',
    status: TicketStatus.resolved,
    priority: TicketPriority.medium,
    accountId: 'account-a',
    portalId: 'portal-a',
    dataCenter: DataCenter.india,
    contactId: 'contact-alice',
    contactName: 'Alice Johnson',
    contactEmail: 'alice@example.com',
    createdAt: _baseA.subtract(const Duration(days: 14)),
    updatedAt: _baseA.subtract(const Duration(days: 7)),
    commentCount: 3,
    hasUnread: false,
    customFieldValues: const {
      'region': 'East',
      'affected_users': 1,
    },
    product: 'Zoho Desk',
    category: 'Widget',
    closedAt: _baseA.subtract(const Duration(days: 7)),
  ),
  // Bob's ticket — must be rejected if Alice targets it.
  Ticket(
    id: 'ticket-a-bob',
    ticketNumber: '48150',
    subject: 'Bulk import failing for large CSV files',
    description: 'Bob Smith internal ticket — not visible to Alice.',
    status: TicketStatus.open,
    priority: TicketPriority.low,
    accountId: 'account-a',
    portalId: 'portal-a',
    dataCenter: DataCenter.india,
    contactId: 'contact-bob',
    contactName: 'Bob Smith',
    contactEmail: 'bob@northwind.com',
    createdAt: _baseA.subtract(const Duration(days: 3)),
    updatedAt: _baseA.subtract(const Duration(days: 3)),
    product: 'Zoho CRM',
    category: 'Import',
  ),
];

// ---------------------------------------------------------------------------
// Tickets — Portal B (Brightline Analytics, US DC)
// ---------------------------------------------------------------------------

final _baseB = DateTime(2024, 11, 5);

final mockTicketsB = <Ticket>[
  Ticket(
    id: 'ticket-b1',
    ticketNumber: '22041',
    subject: 'Dashboard charts not rendering after workspace migration',
    description:
        'After migrating our workspace to the new region, all chart widgets on the main dashboard '
        'display a spinner indefinitely. The underlying data appears intact (table views work). '
        'This is affecting our daily standup reports.',
    status: TicketStatus.open,
    priority: TicketPriority.high,
    accountId: 'account-b',
    portalId: 'portal-b',
    dataCenter: DataCenter.us,
    contactId: 'contact-alice',
    contactName: 'Alice Johnson',
    contactEmail: 'alice@example.com',
    createdAt: _baseB.subtract(const Duration(days: 3)),
    updatedAt: _baseB.subtract(const Duration(hours: 6)),
    commentCount: 1,
    hasUnread: true,
    customFieldValues: const {
      'environment': 'Production',
      'workspace_url': 'https://analytics.brightline.io/main',
      'business_impact':
          'Daily stand-up and exec dashboard unavailable. Revenue reporting delayed.',
      'reproducible': true,
    },
    product: 'Zoho Analytics',
    category: 'Dashboards',
  ),
  Ticket(
    id: 'ticket-b2',
    ticketNumber: '22019',
    subject: 'Creator app form submissions not triggering webhook',
    description:
        'Our Zoho Creator form is set up to POST to an external webhook on submit. '
        'Since last Tuesday the webhook is not being called. Staging environment works fine.',
    status: TicketStatus.onHold,
    priority: TicketPriority.medium,
    accountId: 'account-b',
    portalId: 'portal-b',
    dataCenter: DataCenter.us,
    contactId: 'contact-alice',
    contactName: 'Alice Johnson',
    contactEmail: 'alice@example.com',
    createdAt: _baseB.subtract(const Duration(days: 8)),
    updatedAt: _baseB.subtract(const Duration(days: 2)),
    commentCount: 4,
    hasUnread: false,
    customFieldValues: const {
      'environment': 'Production',
      'workspace_url': 'https://creator.brightline.io/apps/intake-form',
      'business_impact': 'Lead intake process broken. Manual workaround in place.',
      'reproducible': false,
    },
    product: 'Zoho Creator',
    category: 'Webhooks',
  ),
  // Carol's ticket — must be rejected if Alice targets it.
  Ticket(
    id: 'ticket-b-carol',
    ticketNumber: '22055',
    subject: 'SAML SSO configuration issue',
    description: 'Carol Davis internal ticket — not visible to Alice.',
    status: TicketStatus.open,
    priority: TicketPriority.high,
    accountId: 'account-b',
    portalId: 'portal-b',
    dataCenter: DataCenter.us,
    contactId: 'contact-carol',
    contactName: 'Carol Davis',
    contactEmail: 'carol@brightline.com',
    createdAt: _baseB.subtract(const Duration(days: 1)),
    updatedAt: _baseB.subtract(const Duration(days: 1)),
    product: 'Zoho Analytics',
    category: 'Authentication',
  ),
];

// ---------------------------------------------------------------------------
// Tickets — Portal C (Harbor Health Clinics, India DC)
// ---------------------------------------------------------------------------

final _baseC = DateTime(2024, 11, 3);

final mockTicketsC = <Ticket>[
  Ticket(
    id: 'ticket-c1',
    ticketNumber: '33501',
    subject: 'Patient appointment reminders not sending via SMS',
    description:
        'Our automated SMS reminders for patient appointments stopped sending 3 days ago. '
        'Email reminders are working fine. Affected departments: Cardiology, Orthopaedics.',
    status: TicketStatus.open,
    priority: TicketPriority.urgent,
    accountId: 'account-c',
    portalId: 'portal-c',
    dataCenter: DataCenter.india,
    contactId: 'contact-alice',
    contactName: 'Alice Johnson',
    contactEmail: 'alice@example.com',
    createdAt: _baseC.subtract(const Duration(days: 3)),
    updatedAt: _baseC.subtract(const Duration(hours: 4)),
    commentCount: 2,
    hasUnread: true,
    customFieldValues: const {
      'affected_departments': ['Cardiology', 'Orthopaedics'],
    },
    product: 'Zoho Desk',
    category: 'Notifications',
  ),
  Ticket(
    id: 'ticket-c2',
    ticketNumber: '33412',
    subject: 'Lab results upload failing for files over 5 MB',
    description:
        'When staff try to attach lab result PDFs larger than 5 MB, the upload fails silently. '
        'Smaller files upload fine.',
    status: TicketStatus.resolved,
    priority: TicketPriority.high,
    accountId: 'account-c',
    portalId: 'portal-c',
    dataCenter: DataCenter.india,
    contactId: 'contact-alice',
    contactName: 'Alice Johnson',
    contactEmail: 'alice@example.com',
    createdAt: _baseC.subtract(const Duration(days: 10)),
    updatedAt: _baseC.subtract(const Duration(days: 5)),
    commentCount: 6,
    attachmentCount: 2,
    hasUnread: false,
    customFieldValues: const {
      'affected_departments': ['Pathology'],
    },
    product: 'Zoho Desk',
    category: 'Attachments',
    closedAt: _baseC.subtract(const Duration(days: 5)),
  ),
  // Dave's ticket — must be rejected if Alice targets it.
  Ticket(
    id: 'ticket-c-dave',
    ticketNumber: '33488',
    subject: 'User access provisioning error',
    description: 'Dave Wilson internal ticket — not visible to Alice.',
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    accountId: 'account-c',
    portalId: 'portal-c',
    dataCenter: DataCenter.india,
    contactId: 'contact-dave',
    contactName: 'Dave Wilson',
    contactEmail: 'dave@harborhealth.com',
    createdAt: _baseC.subtract(const Duration(days: 2)),
    updatedAt: _baseC.subtract(const Duration(days: 2)),
    product: 'Zoho Desk',
    category: 'Access',
  ),
];

/// All tickets indexed by portal ID.
final mockTicketsByPortal = <String, List<Ticket>>{
  'portal-a': mockTicketsA,
  'portal-b': mockTicketsB,
  'portal-c': mockTicketsC,
};

// ---------------------------------------------------------------------------
// Ongoing issues
// ---------------------------------------------------------------------------

final _now = DateTime(2024, 11, 6, 10, 0);

final mockOngoingIssues = <OngoingIssue>[
  // Active CRM degradation — India DC
  OngoingIssue(
    id: 'issue-1',
    title: 'Zoho CRM — Contact sync degradation',
    description:
        'We are currently investigating reports of delayed contact synchronisation between '
        'Zoho CRM and third-party integrations in the India data center. Some users may '
        'experience sync delays of up to 30 minutes.',
    status: IssueStatus.investigating,
    severity: IssueSeverity.high,
    affectedProducts: const ['Zoho CRM'],
    affectedDataCenters: const [DataCenter.india],
    startedAt: _now.subtract(const Duration(hours: 4)),
    updatedAt: _now.subtract(const Duration(minutes: 30)),
    timeline: [
      IssueUpdate(
        id: 'iu-1-1',
        content: 'We are investigating reports of delayed contact sync in the India DC.',
        status: IssueStatus.active,
        timestamp: _now.subtract(const Duration(hours: 4)),
      ),
      IssueUpdate(
        id: 'iu-1-2',
        content:
            'Root cause identified: a background sync worker is experiencing elevated queue depth. '
            'A fix is being deployed.',
        status: IssueStatus.investigating,
        timestamp: _now.subtract(const Duration(minutes: 30)),
      ),
    ],
  ),
  // Analytics outage — US DC
  OngoingIssue(
    id: 'issue-2',
    title: 'Zoho Analytics — Dashboard rendering unavailable',
    description:
        'Zoho Analytics dashboard charts are not rendering for users in the US data center. '
        'Table views and data exports are unaffected.',
    status: IssueStatus.active,
    severity: IssueSeverity.critical,
    affectedProducts: const ['Zoho Analytics'],
    affectedDataCenters: const [DataCenter.us],
    startedAt: _now.subtract(const Duration(hours: 7)),
    updatedAt: _now.subtract(const Duration(hours: 1)),
    timeline: [
      IssueUpdate(
        id: 'iu-2-1',
        content: 'Incident opened. Chart rendering service unresponsive in US DC.',
        status: IssueStatus.active,
        timestamp: _now.subtract(const Duration(hours: 7)),
      ),
      IssueUpdate(
        id: 'iu-2-2',
        content:
            'Engineering team investigating. A rollback of the 04-Nov deployment is being evaluated.',
        status: IssueStatus.investigating,
        timestamp: _now.subtract(const Duration(hours: 3)),
      ),
      IssueUpdate(
        id: 'iu-2-3',
        content: 'Rollback initiated. Expect resolution within 2 hours.',
        status: IssueStatus.investigating,
        timestamp: _now.subtract(const Duration(hours: 1)),
      ),
    ],
  ),
  // Scheduled Books maintenance — India DC
  OngoingIssue(
    id: 'issue-3',
    title: 'Zoho Books — Scheduled maintenance window',
    description:
        'Zoho Books will undergo scheduled infrastructure maintenance in the India data center. '
        'The service will be briefly unavailable.',
    status: IssueStatus.scheduled,
    severity: IssueSeverity.medium,
    affectedProducts: const ['Zoho Books'],
    affectedDataCenters: const [DataCenter.india],
    startedAt: _now.add(const Duration(days: 2)),
    scheduledFor: _now.add(const Duration(days: 2)),
    updatedAt: _now.subtract(const Duration(days: 1)),
    timeline: [
      IssueUpdate(
        id: 'iu-3-1',
        content:
            'Maintenance scheduled for 08-Nov 02:00–04:00 IST. Zoho Books will be briefly unavailable.',
        status: IssueStatus.scheduled,
        timestamp: _now.subtract(const Duration(days: 1)),
      ),
    ],
  ),
  // Resolved incident
  OngoingIssue(
    id: 'issue-4',
    title: 'Zoho Desk — Email-to-ticket delays (resolved)',
    description:
        'Incoming emails were not being converted to tickets in a timely manner. '
        'This issue has been resolved.',
    status: IssueStatus.resolved,
    severity: IssueSeverity.medium,
    affectedProducts: const ['Zoho Desk'],
    affectedDataCenters: const [DataCenter.india, DataCenter.us],
    startedAt: _now.subtract(const Duration(days: 3, hours: 5)),
    resolvedAt: _now.subtract(const Duration(days: 3)),
    updatedAt: _now.subtract(const Duration(days: 3)),
    timeline: [
      IssueUpdate(
        id: 'iu-4-1',
        content: 'Reports of email-to-ticket delays received.',
        status: IssueStatus.active,
        timestamp: _now.subtract(const Duration(days: 3, hours: 5)),
      ),
      IssueUpdate(
        id: 'iu-4-2',
        content: 'Issue resolved. Email processing queue cleared. All tickets now created.',
        status: IssueStatus.resolved,
        timestamp: _now.subtract(const Duration(days: 3)),
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Notifications
// ---------------------------------------------------------------------------

final mockNotifications = <NotificationItem>[
  NotificationItem(
    id: 'notif-1',
    type: NotificationType.comment,
    accountId: 'account-a',
    portalId: 'portal-a',
    dataCenter: DataCenter.india,
    targetType: NotificationTargetType.ticket,
    targetId: 'ticket-a1',
    title: 'New reply on ticket #48213',
    body: 'Zoho Support replied to your ticket "CRM records not syncing to Books".',
    receivedAt: _now.subtract(const Duration(hours: 2)),
    isRead: false,
  ),
  NotificationItem(
    id: 'notif-2',
    type: NotificationType.statusChange,
    accountId: 'account-b',
    portalId: 'portal-b',
    dataCenter: DataCenter.us,
    targetType: NotificationTargetType.ticket,
    targetId: 'ticket-b1',
    title: 'Ticket #22041 updated',
    body: 'Your ticket status changed to In Progress.',
    receivedAt: _now.subtract(const Duration(hours: 6)),
    isRead: false,
  ),
  NotificationItem(
    id: 'notif-3',
    type: NotificationType.incidentAlert,
    accountId: 'account-b',
    portalId: 'portal-b',
    dataCenter: DataCenter.us,
    targetType: NotificationTargetType.issue,
    targetId: 'issue-2',
    title: 'Service incident affecting Zoho Analytics',
    body: 'Dashboard rendering is currently unavailable in the US data center.',
    receivedAt: _now.subtract(const Duration(hours: 7)),
    isRead: true,
  ),
  NotificationItem(
    id: 'notif-4',
    type: NotificationType.maintenanceAlert,
    accountId: 'account-a',
    portalId: 'portal-a',
    dataCenter: DataCenter.india,
    targetType: NotificationTargetType.issue,
    targetId: 'issue-3',
    title: 'Upcoming maintenance: Zoho Books',
    body: 'Scheduled maintenance on 08-Nov 02:00–04:00 IST.',
    receivedAt: _now.subtract(const Duration(days: 1)),
    isRead: true,
  ),
];
