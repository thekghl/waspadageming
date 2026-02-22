## 1. Project Configuration

- [x] 1.1 Add `geolocator` dependency to `pubspec.yaml` <!-- id: 1 -->
- [x] 1.2 Update Android `AndroidManifest.xml` with `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` permissions <!-- id: 2 -->
- [x] 1.3 Update iOS `Info.plist` with `NSLocationWhenInUseUsageDescription` <!-- id: 3 -->

## 2. Location Tracking Logic

- [x] 2.1 Refactor `HomePage` to request location permissions and fetch the initial GPS coordinates on load. Ensure fallback handling if denied. <!-- id: 4 -->
- [x] 2.2 Update the `FlutterMap` initialization and `MapController` logic in `HomePage` to gracefully accept and move to dynamic coordinates. <!-- id: 5 -->
- [x] 2.3 Refactor the `FloatingActionButton` ("Return to Current Location") to use the live location service. <!-- id: 6 -->

## 3. Map Visuals

- [x] 3.1 Add a `MarkerLayer` to the `FlutterMap` that renders a distinct blue user location dot at the fetched coordinates. <!-- id: 7 -->
