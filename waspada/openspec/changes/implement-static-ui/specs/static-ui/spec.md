## ADDED Requirements

### Requirement: Home Page Content Layout
The system SHALL display a Home Page serving as the primary map interface.

#### Scenario: Viewing the Home Page
- **WHEN** the user opens the application
- **THEN** the system displays a fullscreen map representation (static placeholder)
- **THEN** the system displays a top search bar component
- **THEN** the system displays an avatar or menu icon for accessing additional options
- **THEN** the system displays a 'Return to Current Location' button overlaid on the map

### Requirement: Earthquake Detail Sheet
The system SHALL provide a detailed view for specific earthquake events on the map.

#### Scenario: Viewing earthquake details
- **WHEN** the user interacts with an earthquake point on the Home Page
- **THEN** the system pulls up a detailed bottom sheet over the map
- **THEN** the sheet displays the Location, Coordinates, "Terkonfirmasi" badge, and Timestamp
- **THEN** the sheet displays a split card showing a Magnitude indicator and a Depth indicator with icons
- **THEN** the sheet displays a sortable history table indicating Time (WIB), Depth, and Magnitude

### Requirement: Home Page Dropdown Menu
The system SHALL provide an accessible menu from the Home Page for quick actions.

#### Scenario: Opening the dropdown menu
- **WHEN** the user taps the avatar/menu icon on the Home Page
- **THEN** an overlay menu appears containing options for: Safety Guide, Emergency Contact Setup, and Distress Mode

### Requirement: Distress Mode UI
The system SHALL have a specialized high-priority visual mode for distress situations.

#### Scenario: Activating Distress Mode
- **WHEN** the Distress Mode is triggered
- **THEN** the UI changes to a prominent red theme
- **THEN** the screen displays a large warning triangle icon with the magnitude (e.g., "9.8 SR")
- **THEN** the screen displays the location name, coordinates, verification badge, and timestamp
- **THEN** the screen displays a white card with an advisory message ("Tidak ada lagi yang bisa dilakukan...")
- **THEN** the screen displays "SOS light" and "Emergency Contact" action buttons
- **THEN** the screen displays a wide white "Slide to turn off" container at the bottom

### Requirement: Search Page Layout
The system SHALL provide a dedicated screen for searching locations.

#### Scenario: Viewing the search screen
- **WHEN** the user taps the search bar on the Home Page
- **THEN** the system displays a Search Page showing previous search history and a text input field
