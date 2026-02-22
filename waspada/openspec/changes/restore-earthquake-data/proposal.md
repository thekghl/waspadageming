## Why

The user requested to restore the earthquake data feature after it was previously removed. This feature provides critical situational awareness regarding recent seismic activity.

## What Changes

- **HomePage UI**: Restore the bottom earthquake summary card, interactive map markers, and earthquake-specific loading states.
- **Service Integration**: Re-enable the periodic fetching of earthquake data from the established API endpoint.

## Capabilities

### Restored Capabilities
- `earthquake-data-fetching`: Users can once again view markers and details for recent earthquakes.
- `earthquake-details`: Map markers are interactive, showing depth and precise coordinates in a bottom sheet.

## Impact

- `lib/home_page.dart`: UI will be restored to its premium, data-rich state.
