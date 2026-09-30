# Zoho Support Hub

A Flutter mobile app for Zoho Desk Help Center customers — submit and track support tickets, chat with Zia, and monitor service status.

## Features

- **Tickets** — list, filter, create, reply, change status/priority
- **Zia** — conversational assistant for ticket queries and service status
- **Ongoing Issues** — live Zoho service status feed grouped by severity
- **Notifications** — grouped inbox with mark-read and deep links
- **Settings** — theme (light/dark/system), accent color, notification prefs, multi-account

## Getting Started

### Prerequisites

- Flutter 3.32+ / Dart 3.8+
- Android Studio or Xcode for device targets

### Run (mock mode — no credentials needed)

```bash
flutter pub get
flutter run --dart-define=APP_ENV=mock
```

### Run (live mode — requires Zoho OAuth credentials)

```bash
flutter run --dart-define=APP_ENV=live \
            --dart-define=ZOHO_CLIENT_ID=<your_client_id>
```

Register your OAuth client at [api-console.zoho.com](https://api-console.zoho.com) with:
- **Redirect URI**: `zohosupporthub://oauth`
- **Scopes**: `Desk.tickets.ALL,Desk.contacts.READ,Desk.settings.READ`

### Build APK (debug)

```bash
flutter build apk --dart-define=APP_ENV=mock
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Build APK (release — requires signing config)

```bash
flutter build apk --release \
  --dart-define=APP_ENV=live \
  --dart-define=ZOHO_CLIENT_ID=<your_client_id>
```

### Build iOS (requires Mac + Xcode)

```bash
flutter build ipa --dart-define=APP_ENV=live \
                  --dart-define=ZOHO_CLIENT_ID=<your_client_id>
```

## Architecture

```
lib/
  app/          — theme, router, shell, config
  core/         — errors, HTTP client, token storage
  features/
    accounts/   — DeskAccount, UserProfile, AccountContext
    authentication/ — AuthRepository (mock + Zoho OAuth2)
    tickets/    — TicketRepository (mock + Zoho Desk REST)
    zia/        — ZiaRepository (mock + Zia API)
    ongoing_issues/ — status feed (mock + Zoho Status API)
    notifications/  — inbox (mock + Zoho Desk push)
    settings/   — theme, notification prefs
  shared/       — PaginatedResult, AccountChip
test/           — unit tests for repositories and domain models
```

All screens are decoupled from data sources via repository interfaces.
Switch `APP_ENV=mock` ↔ `APP_ENV=live` without touching any screen code.

## Security

- Tokens stored exclusively in `flutter_secure_storage`
- No secrets in source — credentials via `--dart-define` only
- Mock repositories enforce the same authorization rules as the live layer
- Zia output is treated as untrusted; prompt injection is blocked
