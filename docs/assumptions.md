# Assumptions

This file documents assumptions made during development where the product brief is ambiguous.

## Phase 1 / Mock Layer

- Inter font files are expected to be placed in `assets/fonts/Inter/`. The app ships with stubs until the actual font files are added; Material Design 3 falls back to Roboto if Inter is missing at runtime.
- `flutter_local_notifications` requires platform-specific setup for Android notification channels and iOS permission requests. The Simulation panel in Settings will request permission at first use.
- `image_picker` on Android requires the READ_MEDIA_IMAGES and READ_MEDIA_VIDEO permissions. On iOS it uses the NSPhotoLibraryUsageDescription key. Both are declared in the respective platform manifests.
- `file_picker` on Android requires READ_EXTERNAL_STORAGE (API ≤32) or READ_MEDIA_* (API ≥33) and needs the `manageExternalStorage` flag for broader access; scoped storage is acceptable for Phase 1.
- Biometric / device authentication is out of scope for Phase 1. Token storage via `flutter_secure_storage` is the only auth persistence mechanism.
- The Zoho data-center list for mock purposes: India (IN) at `desk.zoho.in`, US at `desk.zoho.com`. Additional DCs (EU, AU, JP, CA, SA) are modelled but not fully exercised in mock data.
- Custom accent colors derived from the user's colour picker use the HSL lightness-adjustment algorithm described in the brief; the exact thresholds (4.5:1 light, 5:1 dark) are verified at runtime in debug mode via `assert`.
- Zia intent matching uses simple keyword + regex; no NLP library is added in Phase 1.
