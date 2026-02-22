# Design: Dynamic Recent Searches

## Overview
The Dynamic Recent Searches feature replaces the hardcoded recent searches in `SearchPage` with a persistent, dynamic list. We use the `shared_preferences` package to serialize the history of selected `LocationResult` objects to local device storage.

## Architecture & Approach

### 1. Persistent Storage (shared_preferences)
We will use `shared_preferences` to save a list of strings (each string being a JSON-encoded `LocationResult`).
- **Key**: `'recent_searches'`
- **Limit**: To prevent the payload from growing indefinitely, we will cap the list at the 5 most recent unique searches.

### 2. LocationResult Model Updates
To facilitate saving to `shared_preferences`, we must add serialization methods:
```dart
Map<String, dynamic> toJson() {
  return {
    'display_name': name,
    'lat': latitude.toString(),
    'lon': longitude.toString(),
  };
}
```

### 3. RecentSearchesService
To decouple storage logic from UI code, we will create a dedicated service class `RecentSearchesService`:
- `static Future<List<LocationResult>> getRecentSearches()`
- `static Future<void> addRecentSearch(LocationResult result)`: Adds the new result to the top. If the exact same location exists, it moves it to the top. Enforces the 5-item limit.
- `static Future<void> clearRecentSearches()`

### 4. SearchPage State & UI
- **State Variables**:
  - Add `List<LocationResult> _recentSearches = [];`
  - Add `bool _isLoadingRecent = true;`
- **Initialization**:
  - In `initState`, call an async function to load `_recentSearches` from the service, then call `setState`.
- **UI Logic Update**:
  - When `_searchController.text.isEmpty` (and not fetching live results), display the `_recentSearches` list.
  - If `_recentSearches` is empty, display a placeholder like "No recent searches yet".
  - Add a "Clear" text button aligned to the right of the "Recent Searches" header.
- **Selection Logic Upate**:
  - When a user taps a live API result in the `ListView`, call `await RecentSearchesService.addRecentSearch(result)` *before* popping the navigator:
  ```dart
  onTap: () async {
    await RecentSearchesService.addRecentSearch(result);
    if (context.mounted) Navigator.pop(context, result);
  }
  ```
  - When a user taps a *recent* search result, they also pop immediately returning that result.

## Data Models
The `LocationResult` class ensures type safety. It currently accepts `display_name`, `lat`, and `lon` via its `fromJson` factory. The new `toJson` method will produce an identical map structure.

## Error Handling
- **Storage Errors**: `shared_preferences` rarely throws exceptions unless the file system is corrupted. However, if JSON decoding fails for a given string (e.g., legacy corrupted data), we will silently catch `FormatException` and filter out the bad entry.

## Testing Strategy
- **Manual Verification**: Run on an emulator.
  1. Open SearchPage. Verify "Recent Searches" is empty (or says "No recent searches").
  2. Search for "Bandung", select it. Map moves.
  3. Open SearchPage again. Verify "Bandung" is listed under Recent Searches.
  4. Search for "Cimahi", select it. 
  5. Open SearchPage again. Verify "Cimahi" is at the top, "Bandung" is second.
  6. Tap "Clear". Verify the list empties.
