## ADDED Requirements

### Requirement: Request Device Location Permission
The system SHALL request access to the device's location services before attempting to determine the user's geographic position.

#### Scenario: User launches the map for the first time
- **WHEN** the `HomePage` is loaded for the first time
- **THEN** the system requests foreground location permissions
- **THEN** if granted, the system fetches the current coordinates
- **THEN** if denied, the system defaults to a fallback location and continues operating normally

### Requirement: Show User Location on Map
The system SHALL display a visual indicator representing the user's current geographic location on the map.

#### Scenario: Displaying the location dot
- **WHEN** valid GPS coordinates are obtained from the device
- **THEN** the map displays a distinct blue marker indicating the user position
- **THEN** the map automatically centers on this position upon first load
