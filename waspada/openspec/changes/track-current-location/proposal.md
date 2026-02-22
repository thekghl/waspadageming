## Why

To enhance the utility of the Waspada application, the interactive map should not just be static or default to a hardcoded center but instead reflect the user's real-time geographic location. This solves the user's need to quickly identify their proximity to ongoing disaster events (like earthquakes) in real-time, greatly improving context-awareness and safety.

## What Changes

- Implement device location services to fetch the user's current GPS coordinates.
- Request appropriate location permissions from the user.
- Add a user location indicator (e.g., a blue dot) on the `HomePage` map.
- Wire the existing 'Return to Current Location' FloatingActionButton to actually lock the map center to the user's real GPS coordinates instead of the hardcoded default.
- Add robust error handling if the location service is disabled or permission is denied by the user.

## Capabilities

### New Capabilities
- `location-tracking`: The system will utilize device GPS/location services to show the user's position on the map and allow fast recentering.

### Modified Capabilities
- `static-ui`: The map and 'Return to Location' button will be updated to accept real dynamic data instead of static placeholders.

## Impact

- **Dependencies**: Introduces new dependencies like `geolocator` to handle cross-platform location permissions and GPS coordinate fetching.
- **Permissions**: Modifies the `AndroidManifest.xml` and `Info.plist` to declare location permissions.
- **Code**: Modifies `HomePage` logic to initialize location services and update the `flutter_map` controller parameters dynamically.
