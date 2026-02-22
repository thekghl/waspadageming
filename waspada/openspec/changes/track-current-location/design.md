# Design for Location Tracking

## Context

Currently, the map on the `HomePage` initializes to a hardcoded center point and the "Return to Location" button simply pans back to that static point. To enhance the utility of the Waspada application, the map should reflect the user's real geographic location so they can quickly determine their proximity to earthquake events.

## Goals

- Obtain user permission to access device location.
- Fetch the user's current GPS coordinates.
- Ensure the `flutter_map` widget initializes its center to the user's location (or pans to it once found).
- Update the "Return to Location" floating action button to track the live location.

## Decisions

1. **Dependency Plugin**: We will introduce the `geolocator` Flutter package because it provides a reliable, cross-platform API for checking permissions and fetching device location data.
2. **State Management**: The `HomePage` will manage the location state using boolean variables (`_isTrackingLocation`) and hold the retrieved `LatLng` coordinate.
3. **Map Centering Flow**: 
    - The page will attempt to fetch location on init.
    - If found and permitted, the map controller moves the camera to the new coordinate.
    - If denied, we fail gracefully and use a fallback coordinate (e.g., Jakarta center or the current mock coordinate).
4. **Visual Indicator**: We will use a `MarkerLayer` within the `FlutterMap` widget to render a simple blue circle (or typical user location indicator) representing the user's current spot securely.

## Risks

- **Permissions Handling**: Users might permanently deny permissions. We must ensure the app doesn't crash and the map still functions (load fallback coordinates).
- **Location Delays**: Getting accurate GPS on some Android devices takes time. We will first fetch the latest known location to speed up the UX, followed by a high-accuracy request if necessary.

## Migration Plan

- Adds `geolocator` to `pubspec.yaml`.
- Requires adding `NSLocationWhenInUseUsageDescription` in iOS `Info.plist` and `ACCESS_COARSE_LOCATION` plus `ACCESS_FINE_LOCATION` in Android's `AndroidManifest.xml`.
