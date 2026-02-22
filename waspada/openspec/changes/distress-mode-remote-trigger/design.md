## Context

The application currently has a `DistressModePage` that can be manually activated. The goal is to allow automated activation via a remote signal (OneSignal) to handle scenarios where the user cannot manually interact with the phone.

## Goals / Non-Goals

**Goals:**
- Enable remote activation of `DistressModePage`.
- **CRITICAL**: Automatically launch the app/activity from the background when a signal is received (Android).
- Support background-to-foreground transition on Android where possible.
- Provide a clean integration with OneSignal.

**Non-Goals:**
- Implementing a complete notification management system.
- iOS specific background overrides (limited by system).

## Decisions

1. **Global Navigator Key**: To facilitate navigation from a static service or background handler, a `GlobalKey<NavigatorState>` will be added to `MaterialApp`.
2. **Notification Data Schema**: We will use a custom JSON payload key `type` with the value `distress_trigger` to identify emergency signals.
3. **Internal Activity Launch**: On Android, we will utilize `USE_FULL_SCREEN_INTENT` and high-priority channels to ensure the activity is surfaced even from the background. We will also consider `SYSTEM_ALERT_WINDOW` if the full-screen intent is insufficient for certain OS versions.
4. **Service Layer**: A `DistressRemoteService` will wrap OneSignal logic to keep `main.dart` clean.

## Risks / Trade-offs

- **Risk: Duplicate Navigation** -> A signal received while the app is already in Distress Mode could push it again. *Mitigation*: Implementation will check the current route before pushing.
- **Risk: Android Background Restrictions** -> Android 10+ restricts starting activities from the background. *Mitigation*: We will use `USE_FULL_SCREEN_INTENT` which is the designated exception for alarms and emergency signals.
