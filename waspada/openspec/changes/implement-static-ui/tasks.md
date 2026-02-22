## 1. Project Setup & Core Components

- [x] 1.1 Create `assets/images` directory and add placeholder images (map background).
- [x] 1.2 Update `pubspec.yaml` to include the new image assets.
- [x] 1.3 Create a shared UI components folder (`lib/widgets/`) for reusable elements like buttons and text styles.

## 2. Home Page Implementation

- [x] 2.1 Create the base `HomePage` layout with the map background placeholder.
- [x] 2.2 Implement the top Search Bar widget on the `HomePage`.
- [x] 2.3 Implement the Avatar/Menu Icon button on the `HomePage`.
- [x] 2.4 Implement the 'Return to Current Location' button overlaid on the `HomePage` map.

## 3. Overlay and Navigation Implementations

- [x] 3.1 Create the `EarthquakeDetailSheet` bottom sheet widget with mock details and history list.
- [x] 3.2 Implement the gesture detector on the `HomePage` map placeholder to trigger the `EarthquakeDetailSheet`.
- [x] 3.3 Create the `HomeDropdownMenu` overlay widget with links to Safety Guide, Emergency Contact, and Distress Mode.
- [x] 3.4 Wire the Avatar icon to open the `HomeDropdownMenu`.

## 4. Alternate Screens Implementation

- [x] 4.1 Create the `SearchPage` UI with the text input and mock search history list.
- [x] 4.2 Connect the `HomePage` Search Bar to navigate to the `SearchPage`.
- [x] 4.3 Create the `DistressModePage` UI, featuring the red theme, SOS button, and "Slide to turn off" widget.
- [x] 4.4 Connect the `HomeDropdownMenu` Distress Mode option to navigate to the `DistressModePage`.
- [x] 4.5 Implement the return navigation logic on the "Slide to turn off" interaction or a back button in the `DistressModePage`.

## 5. UI Revisions

- [x] 5.1 Revise `DistressModePage` background and SOS button colors to match the exact red hex codes and adjust the SOS button shadow (soft and blurry instead of harsh).
- [x] 5.2 Update the "Slide to turn off >>" container in `DistressModePage` so the sliding white button is larger than the track and bulges out, matching the design.
- [x] 5.3 Format the "Notifying Emergency Contacts:" avatars in `DistressModePage` to visually match the opaque circular background in the design.

## 6. Distress Mode Redesign

- [x] 6.1 Remove the old circular SOS button and replace it with a triangular warning icon containing the magnitude text ("9.8 SR").
- [x] 6.2 Add the earthquake location details (name, coordinates), the green "Terkonfirmasi" badge, and the timestamp.
- [x] 6.3 Add the white advisory message card ("Tidak ada lagi yang bisa dilakukan...").
- [x] 6.4 Add the pill-shaped white action buttons for "SOS light" and "Emergency Contact".
- [x] 6.5 Rebuild the "Slide to turn off" widget to use a white background with a red alarm-off icon slider, matching the new design layout.

## 7. Detail Sheet Redesign

- [x] 7.1 Rebuild `EarthquakeDetailSheet` layout with a draggable handle at the top.
- [x] 7.2 Implement the header section showing Location Name, coordinates, the green "Terkonfirmasi" badge, and Timestamp.
- [x] 7.3 Create the horizontal Magnitude and Depth details card with their respective red and green icons.
- [x] 7.4 Implement the historical data table with the columns: Waktu (WIB), Kedalaman, Magnitudo.
