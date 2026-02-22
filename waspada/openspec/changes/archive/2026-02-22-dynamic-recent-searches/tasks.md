# Tasks: Dynamic Recent Searches

## 1. Setup & Dependencies
- [x] Add `shared_preferences` package to `pubspec.yaml`
- [x] Run `flutter pub get`

## 2. LocationResult Model Updates
- [x] Open `lib/models/location_result.dart`.
- [x] Add a `Map<String, dynamic> toJson()` method to `LocationResult`:
  - `display_name` -> `name`
  - `lat` -> `latitude.toString()`
  - `lon` -> `longitude.toString()`

## 3. Recent Searches Storage (`recent-searches-storage`)
- [x] Create a new file `lib/services/recent_searches_service.dart`.
- [x] Implement `RecentSearchesService` class.
- [x] Add `static const String _key = 'recent_searches';`
- [x] Implement `static Future<List<LocationResult>> getRecentSearches()`:
    - Get `SharedPreferences.getInstance()`.
    - Retrieve string list via `getStringList(_key)`.
    - If null, return `[]`.
    - Map over the string list, decode JSON, and map to `LocationResult.fromJson`.
- [x] Implement `static Future<void> addRecentSearch(LocationResult result)`:
    - Load current list using `getRecentSearches()`.
    - Remove any existing item with the same `name` or (`latitude` and `longitude`).
    - Insert the new `result` at index 0.
    - If list length > 5, remove the last item.
    - Encode the updated list to a JSON string list.
    - Save back using `setStringList(_key, encodedList)`.
- [x] Implement `static Future<void> clearRecentSearches()` to remove `_key`.

## 4. Search UI Integration (`search-page-recent-ui`)
- [x] Open `lib/search_page.dart`.
- [x] Add state variables to `_SearchPageState`: `List<LocationResult> _recentSearches = [];` and `bool _isLoadingRecent = true;`.
- [x] In `initState()`, create an async method `_loadRecentSearches()` to fetch from `RecentSearchesService` and call `setState` to update variables.
- [x] Update the UI where the list is built:
    - When `_searchController.text.isEmpty`: 
        - Show `_recentSearches` list using `ListView.builder`.
        - Add a "Clear" `TextButton` next to the "Recent Searches" header that calls `RecentSearchesService.clearRecentSearches()` and resets the local state.
        - If `_recentSearches` is empty, show "No recent searches yet".
- [x] Update the onTap handler for **Live Results** (the ones shown while typing):
    - `await RecentSearchesService.addRecentSearch(result);`
    - `Navigator.pop(context, result);`
- [x] Update the onTap handler for **Recent Results** (the ones shown when idle):
    - `await RecentSearchesService.addRecentSearch(result);` (moves it to the top)
    - `Navigator.pop(context, result);`

## 5. Testing
- [ ] Run the app.
- [ ] Verify "Recent Searches" is initially empty or shows placeholder.
- [ ] Search and select "Jakarta". Test map moves.
- [ ] Open search again, verify "Jakarta" is in the recent list.
- [ ] Search and select "Bali".
- [ ] Open search again, confirm "Bali" is at the top, "Jakarta" is second.
- [ ] Select "Jakarta" from the recent list.
- [ ] Open search again, confirm "Jakarta" moved back to the top.
- [ ] Click "Clear" and ensure the list immediately vanishes.
