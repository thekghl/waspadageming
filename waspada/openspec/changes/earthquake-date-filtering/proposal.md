## Why

The current earthquake service fetches all recent earthquakes without filtering. To provide more relevant data and optimize network requests, the service needs to support filtering earthquakes by a specific date. This change also updates the API integration to use a new query-parameter-based structure on the `loca.lt` backend.

## What Changes

- **BREAKING**: Modify `EarthquakeService.fetchEarthquakes` to require a `date` parameter.
- Update the API URL construction to include `?date=$date`.
- Remove the dependency on `EARTHQUAKE_API_KEY` if the new endpoint (via `loca.lt`) does not require it (based on the provided snippet).

## Capabilities

### New Capabilities

### Modified Capabilities
- `earthquake-data-service`: Update the fetch requirement to include date filtering and the new URL structure.

## Impact

- `lib/services/earthquake_service.dart`: The main fetching logic will be refactored.
- `lib/home_page.dart`: The call to `fetchEarthquakes` will be updated to pass a default or selected date.
- `lib/config/api_config.dart`: The base URL has already been updated to `https://thick-dogs-buy.loca.lt/`.
