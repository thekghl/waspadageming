# Proposal: SOS Flashlight

## 1. Why
During a distress situation (e.g., an earthquake or tsunami), having a visual SOS signal is critical for search and rescue operations, especially at night or in low visibility. The Distress Mode page currently has an "SOS light" button that serves as a placeholder. Implementing this feature will allow the app to control the device's flashlight to automatically emit a standard distress SOS pattern (three short flashes, three long flashes, three short flashes).

## 2. What Changes
- Integrate a flashlight control dependency (e.g., `torch_light`).
- Implement an asynchronous SOS sequence that blinks the flashlight according to the Morse code standard for SOS.
- Update the `DistressModePage` to handle toggling the SOS sequence on and off.
- Provide visual feedback on the "SOS light" button to indicate whether the SOS sequence is currently active.
- Ensure the flashlight sequence is properly canceled if the user navigates away or slides to turn off distress mode.

## 3. Capabilities
- `sos-blinker`: The logic to start, stop, and precisely time the device flashlight to blink in an SOS pattern.
- `distress-light-ui`: Updates to the `DistressModePage` to control the SOS light state and provide user feedback.

## 4. Impact
- **Dependencies**: Requires a new package like `torch_light` in `pubspec.yaml`.
- **Permissions**: Requires flashlight permission configurations for Android (`AndroidManifest.xml`) and potentially iOS (`Info.plist`).
- **Affected Code**: `lib/distress_mode_page.dart` will be modified to include the new logic, state management, and UI updates.
