## Goals

- Clean up the `HomePage` UI to show only the map and search functionality.
- Ensure the app remains responsive and initializes OneSignal correctly.

## Proposed Changes

### [HomePage Cleanup]

#### [MODIFY] [home_page.dart](file:///d:/projects/waspadageming\waspada\lib\home_page.dart)
- Remove `_fetchEarthquakes` method.
- Remove `MarkerLayer` that displays earthquake markers.
- Remove the bottom `GestureDetector` that displays the recent earthquake summary card.
- Remove `_isLoadingEarthquakes` and related UI overlays.

## Decisions

1. **Retain Search**: The location search bar will be kept to allow users to orient themselves on the map.
2. **Retain User Location**: The blue "current position" marker will be kept.
3. **Lazy Cleanup**: We will keep `EarthquakeService` and the model files in the project for now, but remove all entry points to them from the main UI.
