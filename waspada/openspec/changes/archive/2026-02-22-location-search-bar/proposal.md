# Proposal: Location Search Bar

## 1. Why
Currently, the search bar on the map interface (`SearchPage`) is a static UI that does not actually perform any search. Users need the ability to type a location name, get real suggestions, and move the map to the coordinates of the chosen location to accurately track disaster risks in specific areas.

## 2. What Changes
- Add the `http` package to `pubspec.yaml` to make API requests to a free geocoding service (like OpenStreetMap's Nominatim API).
- Update `SearchPage` to:
  - Handle user input in the `TextField` and debounce the input to prevent excessive API calls.
  - Fetch location results (name, latitude, longitude) from the geocoding API.
  - Display the live results in the list instead of static "Recent Searches".
  - Return the selected coordinates to the previous screen (`HomePage`) when a result is tapped.
- Update `HomePage` to:
  - Wait for the result from `Navigator.push(..., SearchPage)`.
  - Use the `MapController` from `flutter_map` to animate or move the map center to the new coordinates.
  - Add a temporary or permanent marker on the map to pinpoint the searched area exactly.

## 3. Capabilities
- `geocoding-service`: The logic to query a location name and return a list of coordinates and formatted addresses.
- `search-ui-integration`: Updating the `SearchPage` to display live results and handle selection, and updating `HomePage` to handle the selected coordinate result.

## 4. Impact
- **Dependencies**: Requires adding the `http` package.
- **Affected Code**: 
  - `lib/search_page.dart` (Major changes to state management and UI list).
  - `lib/home_page.dart` (Minor changes to handle navigation result and `MapController` center updates).
- **External Systems**: The app will now depend on an external Geocoding API (e.g., Nominatim) which requires an internet connection.
