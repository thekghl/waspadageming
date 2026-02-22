## Why

The Waspada application currently lacks a visual interface for users to interact with. To bring the application to life and enable user flow testing and reviews, we need to implement the static UI screens based on the finalized design assets. This provides the foundational visual layer before integrating dynamic data and backend logic.

## What Changes

- **Add Home Page UI**: Includes the map background placeholder, top search bar, and avatar/dropdown trigger.
- **Add Earthquake Detail Sheet**: A bottom sheet or overlay to display earthquake specifics (magnitude, depth, history list).
- **Add Dropdown Menu**: An overlay menu providing access to the Safety Guide, Emergency Contact Setup, and Distress Mode.
- **Add Search Page UI**: A dedicated screen for searching locations and displaying search history.
- **Add Distress Mode UI**: A critical red-themed screen featuring an SOS button, Emergency Contacts, and a "Slide to turn off" mechanism.
- **Implement Basic Navigation**: Connect these static screens to allow basic user flow (e.g., clicking search opens the Search Page, clicking avatar opens Dropdown).

## Capabilities

### New Capabilities
- `static-ui`: Core capability covering the visual implementation and layout of all primary application screens.
- `navigation`: Basic routing and navigation flow between the static screens.

### Modified Capabilities

- 

## Impact

- **UI Layer**: Extensive additions to the Flutter widget tree and layout structures.
- **Assets**: Inclusion of new static image assets (e.g., placeholder map) into the project's asset bundle.
- **Routing**: Introduction of basic routing setup if not already present.
- **No Backend Impact**: This change is strictly frontend and uses static/mock data; no backend APIs or services are affected.
