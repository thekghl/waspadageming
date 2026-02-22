## ADDED Requirements

### Requirement: Screen Navigation Flow
The system SHALL provide seamless user navigation between core static screens without data persistence.

#### Scenario: Navigating from Home to Search
- **WHEN** the user taps on the Search Bar on the Home Page
- **THEN** the system navigates to the Search Page

#### Scenario: Navigating from Home to Dropdown Menu
- **WHEN** the user taps on the Avatar/Menu Icon on the Home Page
- **THEN** the system displays the Dropdown Menu overlay
- **WHEN** the user dismisses the overlay
- **THEN** the system returns to the clean Home Page view

#### Scenario: Navigating to Distress Mode
- **WHEN** the user selects "Distress Mode" from the Dropdown Menu or another entry point
- **THEN** the system immediately displays the Distress Mode UI
- **WHEN** the user completes the "Slide to turn off" action in Distress Mode
- **THEN** the Distress Mode UI is dismissed
- **THEN** the system returns the user to the previous screen (Home Page)
