# Design for Emergency Contact Intent

## Context

The Distress Mode screen features an "Emergency Contact" button intended to help users quickly reach authorities or saved contacts during an emergency. Currently, it is an inert UI element. This design outlines how we will activate this button using native OS intents to open the device's phone dialer.

## Goals

- Allow users to instantly bridge out to their phone's dialer application.
- Pre-fill the dialer with a configured emergency number (e.g., `112`).
- Ensure graceful fallback if the device cannot handle telephone intents (e.g., Wi-Fi only tablets).

## Decisions

1. **Dependency Plugin**: We will utilize the `url_launcher` package. It is the Flutter-endorsed standard for handling generic URL schemes like `http`, `mailto`, `sms`, and `tel`.
2. **Intent Scheme**: We will use the `tel:<number>` scheme. This opens the dialer without automatically placing the call, allowing the user to confirm the action, which respects system security policies.
3. **Execution Logic**:
   - The `onPressed` handler of the Distress Mode's "Emergency Contact" button will construct the `Uri` for the `tel:` scheme.
   - It will await `canLaunchUrl()` to verify device capability.
   - If capable, it will call `launchUrl()`.
   - If incapable, a robust error message (SnackBar) will be displayed to inform the user.

## Risks

- **Unsupported Devices**: Devices without SIM cards/cellular capability will fail to launch the intent. We must handle the `false` return from `canLaunchUrl()` to avoid a silent failure during a crisis.
- **Strict OS Permissions**: Android 11+ and iOS 9+ enforce strict app visibility/querying rules. The app must declare the schemes it intends to query in both native manifests.

## Migration Plan

- Add `url_launcher` to `pubspec.yaml`.
- Update Android `AndroidManifest.xml` with a `<queries>` tag containing the `tel` intent filter.
- Update iOS `Info.plist` with `LSApplicationQueriesSchemes` array including `tel`.
