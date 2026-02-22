# Design: Location Search Bar

## Overview
The Location Search Bar feature replaces the static "Recent Searches" UI in the `SearchPage` with a live autocomplete search powered by the free OpenStreetMap Nominatim API. When a user selects a location from the search results, the app retrieves its coordinates and animates the `flutter_map` in the `HomePage` to center on the selected location.

## Architecture & Approach

### 1. Geocoding API Integration
We will use the standard `http` package to communicate with the Nominatim API.
- **Endpoint**: `https://nominatim.openstreetmap.org/search?q={query}&format=jsonv2&addressdetails=1`
- **Rate Limiting/Debouncing**: Nominatim requires fair use (max 1 request per second). We will implement a debouncer (e.g., using a `Timer`) in the `SearchPage` to wait 500ms-1000ms after the user stops typing before firing the API request.

### 2. SearchPage State & UI
- **State Variables**:
  - `String _searchQuery`: The current text input.
  - `List<dynamic> _searchResults`: The parsed JSON results from the API.
  - `bool _isLoading`: To show a loading indicator while fetching data.
  - `Timer? _debounce`: For rate limiting.
- **UI Logic**:
  - The `TextField`'s `onChanged` callback will trigger the debouncer.
  - The `ListView` will render `ListTile`s for each result, displaying the `display_name` returned by Nominatim.
  - Tapping a `ListTile` uses `Navigator.pop` to return a `LocationResult` object containing the `lat` and `lon` strings converted to `double`s.

### 3. HomePage Integration
The `HomePage` already uses `flutter_map` with a `MapController`. 
- **Action**: When the user taps the search bar on `HomePage`, they navigate to `SearchPage` and `await` the result.
```dart
final LocationResult? result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const SearchPage()),
);
if (result != null) {
  _mapController.move(LatLng(result.latitude, result.longitude), 12.0);
}
```
- **Map Controller**: Ensure `HomePage` initializes and passes `_mapController` to the `FlutterMap` widget if it doesn't already.

## Data Models
We will define a simple immutable class to pass data back safely:
```dart
class LocationResult {
  final String name;
  final double latitude;
  final double longitude;
  
  LocationResult({required this.name, required this.latitude, required this.longitude});
}
```

## Error Handling
- **API Errors**: If the `http.get` fails (e.g., no internet, 503 error), the `SearchPage` should catch the exception, set `_isLoading = false`, and potentially show a `SnackBar` or a "Failed to load results" text in the list area.
- **Empty Results**: If Nominatim returns an empty list `[]`, display "No locations found".

## Testing Strategy
- **Manual Verification**: Run on an emulator.
  1. Navigate to search.
  2. Type "Jakarta" and pause. Verify the loading indicator appears and results populate.
  3. Select different locations and verify the map on `HomePage` animates precisely to the correct general coordinates.
  4. Test edge cases like rapid typing (debouncer check) and offline mode (error handling).
