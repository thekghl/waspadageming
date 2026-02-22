## ADDED Requirements

### Requirement: Remote Signal Listening
The system SHALL initialize OneSignal on app startup and listen for incoming messages and data notifications.

#### Scenario: OneSignal Initialization
- **WHEN** the app starts
- **THEN** OneSignal is configured with the App ID and starts listening for events.

### Requirement: Automatic Distress Activation
The system SHALL automatically navigate to the `DistressModePage` when a notification contains the `distress_trigger` type in its data payload.

#### Scenario: Foreground Trigger
- **WHEN** the app is in the foreground
- **WHEN** a OneSignal notification is received with `{"type": "distress_trigger"}`
- **THEN** the app immediately displays the `DistressModePage`.

#### Scenario: Background Trigger (Auto-Open)
- **WHEN** the app is in the background or screen is locked
- **WHEN** a OneSignal notification is received with `{"type": "distress_trigger"}`
- **THEN** the system SHALL attempt to launch the app's Main Activity immediately via a High Priority / Full-Screen Intent.
- **THEN** the app opens directly to the `DistressModePage`.
