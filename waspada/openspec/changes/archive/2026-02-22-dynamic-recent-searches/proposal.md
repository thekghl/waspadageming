# Proposal: Dynamic Recent Searches

## 1. Why
Currently, the `SearchPage` displays a hardcoded list of "Recent Searches" (Jakarta, Bali, Tokyo) when the user first opens the page or has an empty search bar. To provide a personalized and useful experience, this list needs to be dynamic, saving the actual locations the user has recently searched for and selected.

## 2. What Changes
- Add the `shared_preferences` package to `pubspec.yaml` to enable persistent local storage on the device.
- Update `SearchPage` to:
  - Load the list of recent searches from `shared_preferences` when the page initializes.
  - Display these dynamic recent searches instead of the hardcoded list when the search query is empty.
  - When the user taps a recent search item, return the `LocationResult` immediately to the `HomePage`.
  - When the user searches and selects a *new* location from the Nominatim API results, save this `LocationResult` to `shared_preferences` (perhaps keeping only the top 5 or 10 most recent to save space).
  - Add a "Clear Recent Searches" button to let the user clear their history.
- Update the `LocationResult` model to add `toJson()` and parsing logic so it can be serialized and saved as a JSON string in `shared_preferences`.

## 3. Capabilities
- `recent-searches-storage`: The logic to serialize, save, load, and clear the list of `LocationResult` objects using `shared_preferences`.
- `search-page-recent-ui`: Updating the `SearchPage` UI to load these recent searches gracefully on startup and display them when the search bar is empty.

## 4. Impact
- **Dependencies**: Requires adding the `shared_preferences` package.
- **Affected Code**: 
  - `lib/models/location_result.dart` (Add JSON serialization).
  - `lib/search_page.dart` (Add `initState` loading, UI for recent searches, and saving on selection).
- **External Systems**: Relies on the device's native key-value storage system.
