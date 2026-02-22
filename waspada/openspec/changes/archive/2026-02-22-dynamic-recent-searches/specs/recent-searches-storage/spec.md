# Spec: Recent Searches Storage

## Overview
The `recent-searches-storage` capability provides local, persistent storage for a user's successful location searches, utilizing the native device key-value store via `shared_preferences`.

## States & Transitions
- **Uninitialized**: Storage has not yet been accessed.
- **Reading**: Extracting and decoding the JSON string list from local storage.
- **Writing**: Encoding and saving a new `LocationResult` to the list in local storage.
- **Clearing**: Removing the specific key from local storage.

## Core Rules
1.  **Storage Mechanism**: Must use the `shared_preferences` flutter package.
2.  **Key**: The specific storage key must be a constant, e.g., `'recent_searches'`.
3.  **Data Structure**: Data must be stored as a `List<String>`. Each string must be a valid JSON representation of a `LocationResult`.
4.  **Capacity Limit**: The storage array must not exceed **5 items**. If a 6th item is added, the oldest (last) item must be removed.
5.  **Uniqueness/Promotion**: If an exact location (identified by its coordinates or display name) is already in the list, it must not be duplicated. Instead, it must be moved to the front (index 0) of the list to indicate it is the most recently searched.

## Edge Cases
-   **Corrupted Data**: If `shared_preferences` returns a string that cannot be decoded via `json.decode()`, or lacks required fields for `LocationResult`, the service should gracefully ignore/drop that specific item and return the rest of the valid list.
-   **Clear Storage**: The clear function must only remove the `'recent_searches'` key, not completely wipe all app preferences using `clear()`, as this might delete other unrelated app settings.
