## Goals

- Restore the full earthquake visualization and information system.
- Ensure a premium, responsive UI for the restored features.

## Proposed Changes

### [HomePage UI Restoration]

#### [MODIFY] [home_page.dart](file:///d:/projects/waspadageming\waspada\lib\home_page.dart)
- Restore `EarthquakeDetailSheet` imports.
- Re-implement the interactive `MarkerLayer` with magnitude-based scaling and coloring.
- Add back the "Recent Earthquake" bottom card with auto-filling logic from the latest data.
- Restore the `CircularProgressIndicator` overlay during fetching.

### [Service Refinement]

#### [MODIFY] [home_page.dart](file:///d:/projects/waspadageming\waspada\lib\home_page.dart)
- Update `_fetchEarthquakes` to use the correct API date format (`yyyy-MM-dd`).

## Decisions

1. **Latest First**: The bottom card will always display information for the most recent earthquake in the fetched list.
2. **Interactive Markers**: Markers will scale based on magnitude to highlight larger events.
