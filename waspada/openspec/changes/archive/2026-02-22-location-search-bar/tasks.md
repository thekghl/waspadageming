# Tasks: Location Search Bar

## 1. Setup & Dependencies
- [x] Add `http` package to `pubspec.yaml`
- [x] Run `flutter pub get`
- [x] Create a new file `lib/models/location_result.dart` defining the `LocationResult` class (name, latitude, longitude).

## 2. Geocoding Service (`geocoding-service`)
- [x] Create a new file `lib/services/geocoding_service.dart`.
- [x] Implement a `GeocodingService` class with a method `Future<List<LocationResult>> fetchLocations(String query)`.
- [x] Send HTTP GET request to `https://nominatim.openstreetmap.org/search?q={query}&format=jsonv2&addressdetails=1`.
- [x] Add a `User-Agent` header to the HTTP request identifying the app (e.g., `WaspadaApp/1.0`).
- [x] Handle non-200 responses and network exceptions by returning an empty list or throwing a custom exception.
- [x] Parse the JSON response into a list of `LocationResult` objects (mapping `display_name`, `lat`, and `lon`).

## 3. Search UI Integration (`search-ui-integration`)
- [x] Open `lib/search_page.dart`.
- [x] Convert `SearchPage` from `StatelessWidget` to `StatefulWidget`.
- [x] Add state variables: `_searchQuery`, `_searchResults` (list of `LocationResult`), `_isLoading`, and `_debounce` (`Timer?`).
- [x] Implement `_onSearchChanged(String query)`:
    - Cancel any active `_debounce` timer.
    - If query is empty, set `_searchResults` to empty and return.
    - Set a new timer for ~800ms. When it fires, call `GeocodingService.fetchLocations`.
    - Update `_isLoading` state before and after the fetch.
- [x] Update the `TextField`'s `onChanged` to call `_onSearchChanged`.
- [x] Replace the hardcoded "Recent Searches" list with a `ListView.builder` iterating over `_searchResults`.
- [x] Show a `CircularProgressIndicator` if `_isLoading` is true.
- [x] In the `ListTile` onTap handler, call `Navigator.pop(context, result)`.

## 4. HomePage Map Integration
- [x] Open `lib/home_page.dart`.
- [x] Update the search bar tap handler to `await Navigator.push` to the `SearchPage`.
- [x] If the result is not null and is type `LocationResult`:
    - Use the existing `_mapController` to call `move(LatLng(result.latitude, result.longitude), 12.0)`.

## 5. Testing
- [ ] Run the app.
- [ ] Tap the search bar and type a city name (e.g., "Bandung").
- [ ] Verify that a loading indicator appears, followed by actual results from Nominatim.
- [ ] Verify that typing quickly does not fire a request for every keystroke (check debug logs if necessary).
- [ ] Tap a result and verify the app returns to `HomePage` and the map animates/moves to the selected city.
- [ ] Disconnect from the internet, try searching, and verify the app does not crash.
