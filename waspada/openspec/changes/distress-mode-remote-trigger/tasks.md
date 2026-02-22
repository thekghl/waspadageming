## 1. Project Configuration

- [x] 1.1 Add `onesignal_flutter` to `pubspec.yaml`
- [x] 1.2 Update `android/app/src/main/AndroidManifest.xml` with OneSignal configurations
- [x] 1.3 Add `USE_FULL_SCREEN_INTENT` and `SYSTEM_ALERT_WINDOW` permissions to Android Manifest

## 2. Core Implementation

- [x] 2.1 Implement `GlobalKey<NavigatorState>` in `MyApp`
- [x] 2.2 Create `DistressRemoteService` and migrate App ID to `.env`
- [x] 2.3 Add logic to check for `distress_trigger` in notification data and perform navigation

## 3. Verification

- [x] 3.1 Log the Player ID to terminal for testing
- [x] 3.2 Send remote signal via Postman and verify UI override
