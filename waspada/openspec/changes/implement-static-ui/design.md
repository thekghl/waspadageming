## Context

The Waspada application requires a visual interface to demonstrate user flows based on the provided design assets. Currently, the application lacks these screens. This design phase focuses purely on building the static UI representation in Flutter without integrating live data or backend services.

## Goals / Non-Goals

**Goals:**
- Implement pixel-perfect static screens for Home, Detail Sheet, Dropdown Menu, Search, and Distress Mode.
- Establish basic Flutter widget structures and component hierarchy.
- Set up simple routing between these static screens to demonstrate the user flow.

**Non-Goals:**
- Integration with real APIs (e.g., BMKG) or backend databases.
- Implementation of complex state management solutions (e.g., Riverpod, BLoC) at this stage.
- Push notification handling or real-time feature implementation.

## Decisions

- **Flutter Widgets**: We will use standard Flutter widgets (e.g., `Scaffold`, `Stack`, `BottomSheet`, `ListView`) to construct the layouts.
- **Mock Data**: Hardcoded strings and placeholder assets will be used to populate the UI (e.g., a static image for the map background).
- **Navigation**: We will use Flutter's built-in `Navigator` (e.g., `Navigator.push`, `showModalBottomSheet`) for simple screen transitions to keep the initial scope manageable.
- **Componentization**: Reusable UI elements (like the SOS button or specific text styles) will be extracted into separate widget files to promote code maintainability from the start.

## Risks / Trade-offs

- **Risk: Duplicate Work Later** -> **Mitigation**: By cleanly separating UI components from data-fetching logic now, we can more easily inject real data and state management later without completely rewriting the UI layer. 
- **Risk: Inaccurate Map Implementation** -> **Mitigation**: Using a static placeholder image for the map might not perfectly reflect the performance or constraints of a real map SDK. This trade-off is acceptable for a static UI phase, but a real map SDK will need to be integrated in a subsequent phase.
