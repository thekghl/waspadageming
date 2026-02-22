# Spec: Search UI Integration

## Overview
The `search-ui-integration` capability manages the user interface in `SearchPage` for inputting queries, displaying live geocoding results, and integrating the selected result back into the `HomePage` map.

## States & Transitions
- **Initial**: The search bar is empty. The list displays "Recent Searches" (or is empty).
- **Typing**: The user is actively typing. A debouncer timer is running.
- **Loading**: The debouncer has fired, and a request was sent to the geocoding service. A `CircularProgressIndicator` is shown below the search bar or in the center.
- **Results Displayed**: The API returned successfully. The list renders `ListTile` items showing the parsed location names.
- **Error Displayed**: The API request failed. A `SnackBar` or error text is shown.
- **Result Selected**: The user taps a result. `Navigator.pop(context, locationResult)` is called.

## Core Rules
1.  **Debouncing**: The `onChanged` event of the `TextField` MUST use a timer (e.g., `Timer(Duration(milliseconds: 800), ...)`) to wait before triggering the `geocoding-service`. If the user types another character before the timer expires, the timer must be cancelled and restarted.
2.  **State Management**: `SearchPage` must use `setState` to transition between `_isLoading`, `_searchResults`, and error states to maintain UI responsiveness.
3.  **Navigation Contract**: `SearchPage` must return a structured object (e.g., `LocationResult`) containing `latitude`, `longitude`, and `name` to the caller.
4.  **Map Integration**: `HomePage` must await the result from `SearchPage`. If a result is received, it must use the `flutter_map` `MapController` to call `move(LatLng(lat, lon), zoomLevel)` to animate the map to the searched location.

## Edge Cases
-   **Rapid Typing to Clear**: If the user types a query, the fetch starts, but then the user rapidly clears the text field before the fetch completes, the UI should handle the late response by ignoring it if the current text field is empty.
-   **Back Button**: If the user presses the back button without selecting anything, `SearchPage` must return `null`. `HomePage` must handle `null` gracefully by doing nothing.
-   **Keyboard Dismissal**: Tapping on a result or scrolling the list should handle keyboard dismissal gracefully to provide a native feel.
