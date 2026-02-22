## Why

In emergency situations, users may not be able to manually activate Distress Mode. Allowing a remote signal (via OneSignal API) to automatically trigger the Distress Mode UI ensures that critical information and SOS tools are presented immediately to the user, potentially saving lives. This change focuses on the Android implementation for high-priority notification handling and UI override.

## What Changes

- Add `onesignal_flutter` dependency to `pubspec.yaml`.
- **BREAKING**: Modify `main.dart` to initialize OneSignal and set up a global navigation key.
- Create `DistressRemoteService` to listen for specific OneSignal "distress_trigger" signals.
- Implement a navigation override that pushes `DistressModePage` when a signal is received.
- **NEW**: Ensure the app automatically opens from the background/lock screen on Android using Full-Screen Intents and High Priority notification channels.
- Update `AndroidManifest.xml` with required permissions and intent filters for high-priority notifications and background activity starts.

## Capabilities

### New Capabilities
- `distress-remote-trigger`: Ability to receive a remote signal and automatically launch the Distress Mode UI.

### Modified Capabilities

## Impact

- `pubspec.yaml`: New dependency.
- `android/app/src/main/AndroidManifest.xml`: Android-specific configurations for background launches.
- `lib/main.dart`: Initialization logic.
- `lib/services/distress_remote_service.dart`: New service for signal handling.
- `lib/distress_mode_page.dart`: May need minor tweaks to handle being launched via remote trigger (initializing with specific data).
