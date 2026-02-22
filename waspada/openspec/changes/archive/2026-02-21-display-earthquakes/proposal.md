## Why

Users need to be aware of recent earthquakes in their vicinity or globally to improve disaster preparedness and situational awareness. By integrating with a custom local API exposed via Cloudflare, the application can fetch and display real-time earthquake data directly on the map.

## What Changes

- Create a new service to fetch earthquake data from the custom Cloudflare API URL.
- Use the `EARTHQUAKE_API_KEY` from the environment for API authentication.
- Update the Map UI to parse and display markers for each earthquake based on its coordinates.
- Add necessary models to represent earthquake data (e.g., coordinates, magnitude, depth, location name).

## Capabilities

### New Capabilities
- `earthquake-data-service`: Fetching and parsing earthquake data from the custom API.
- `earthquake-map-display`: Rendering earthquake markers on the map based on the fetched data.

### Modified Capabilities

## Impact

- `lib/services/`: A new service class will be created for fetching earthquake data.
- `lib/models/`: New model classes will be added for deserializing earthquake JSON responses.
- `lib/screens/home_page.dart` (or related map component): Will be updated to plot earthquake markers as a new layer or overlay.
- `lib/core/` or `lib/utils/`: Updated to securely manage and inject `EARTHQUAKE_API_KEY` and `ApiConfig.baseUrl`.
