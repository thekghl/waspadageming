## ADDED Requirements

### Requirement: Launch Native Dialer Intent
The system SHALL securely pass control to the operating system's native telephone dialer application when requested by the user during an emergency.

#### Scenario: Device supports phone calls
- **WHEN** the user triggers the emergency contact action
- **THEN** the system verifies the device can handle `tel:` schemes
- **THEN** if supported, the system launches the native dialer pre-populated with the target emergency number (e.g., `112`)

#### Scenario: Device lacks phone capabilities
- **WHEN** the user triggers the emergency contact action on a non-cellular device (like a tablet)
- **THEN** the system detects the inability to launch the `tel:` scheme
- **THEN** the system displays a clear, non-blocking error message (e.g., SnackBar) indicating that phone calls are not supported on this device
