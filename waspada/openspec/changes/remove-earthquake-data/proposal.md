## Why

The user wants to streamline the application to prioritize the emergency alert (Distress Mode) functionality and remove the earthquake data fetching feature for now. This avoids connectivity issues with the API/DB and provides a cleaner interface focused on personal safety.

## What Changes

- **HomePage UI**: Remove the bottom earthquake data card, the "memuat data gempa" overlay, and the earthquake markers from the map.
- **Service Logic**: Disable `_fetchEarthquakes` call in `HomePage`.
- **Imports**: Clean up unused imports related to earthquake models/services in `HomePage`.

## Capabilities

### Removed Capabilities
- `earthquake-data-fetching`: Users will no longer see markers or detailed info for recent earthquakes.

## Impact

- `lib/home_page.dart`: Significant UI cleanup.
- `lib/services/earthquake_service.dart`: Remains in codebase but is unreferenced.
