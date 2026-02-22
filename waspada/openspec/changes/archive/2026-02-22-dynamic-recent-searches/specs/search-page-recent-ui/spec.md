# Spec: Search Page Recent UI

## Overview
The `search-page-recent-ui` capability manages the display of the persistent search history on the `SearchPage` when the user has not yet typed a query, replacing the static suggestion list.

## States & Transitions
- **Initializing**: The page is loading the recent searches from storage on `initState`. A loading indicator might not be strictly necessary if it loads instantly, but an empty state should not flicker incorrectly.
- **Idle/Empty Query (With History)**: The search bar is empty, and history exists. The UI displays the history list with a "Clear" button.
- **Idle/Empty Query (No History)**: The search bar is empty, and no history exists. The UI displays a placeholder, e.g., "No recent searches yet".
- **Searching**: The user types a query; the recent searches UI is entirely replaced by the live API results or loading indicator.

## Core Rules
1.  **Loading Data**: Upon navigating to `SearchPage`, it must asynchronously fetch the list from `RecentSearchesService` and update the local state.
2.  **Saving Data (Live Result)**: When the user taps a result from the *live API search*, that specific `LocationResult` must be passed to `RecentSearchesService.addRecentSearch` to save it, *before* popping the navigator.
3.  **Saving Data (Recent Result)**: When the user taps a result from the *recent search list*, it should ideally also promote it to the top of the recent list (by calling addRecentSearch again) before popping the navigator.
4.  **Clear Action**: A UI element (e.g., a text button "Clear") must be visible when recent searches exist. Tapping it must call the service to clear the data and call `setState` to clear the list on screen immediately.

## Edge Cases
-   **First Launch**: On a fresh install, the storage list is empty. The UI must gracefully handle returning an empty list and show the correct placeholder, avoiding any indexing errors.
-   **Delayed Load**: If `shared_preferences` takes an unusual amount of time to load via `await`, the UI should not show the static list or an error, but rather wait or show a subtle loading state.
