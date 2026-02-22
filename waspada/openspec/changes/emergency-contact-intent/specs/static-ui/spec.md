## MODIFIED Requirements

### Requirement: Distress Mode UI
The system SHALL provide a highly visible "Distress Mode" interface for critical situations.

#### Scenario: Activating Distress Mode
- **WHEN** the user selects "Distress Mode" from the Home Page dropdown
- **THEN** the system displays a full-screen, visually urgent alert screen (e.g., solid red background)
- **THEN** the system displays a large warning triangle indicating the event magnitude
- **THEN** the system displays the event location name and coordinates
- **THEN** the system displays an advisory message card providing guidance
- **THEN** the system displays an active "Emergency SOS" button that triggers a system telephone intent when pressed
- **THEN** the system displays a slider widget to turn off or exit the distress mode

### Requirement: Home Page Menu
The system SHALL display a dropdown menu upon avatar tap.

#### Scenario: Using Emergency SOS from Menu
- **WHEN** the user selects "Emergency SOS" from the Home Page dropdown
- **THEN** the system displays an active "Emergency SOS" intent action that triggers a system telephone intent when pressed
