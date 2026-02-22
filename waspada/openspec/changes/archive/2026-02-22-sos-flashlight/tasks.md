# Tasks: SOS Flashlight

## 1. Setup & Dependencies
- [x] Add `torch_light` package to `pubspec.yaml`
- [x] Run `flutter pub get`
- [x] (Optional) Verify Android `AndroidManifest.xml` has flashlight permissions if specifically requested by the plugin (usually implicitly covered by the camera permission or inherently granted).
- [x] (Optional) Verify iOS `Info.plist` has necessary permissions if requested by the plugin.

## 2. Implement SOS Blinker Logic (`sos-blinker`)
- [x] Open `lib/distress_mode_page.dart`
- [x] Add state variable `bool _isSosActive = false;` to `_DistressModePageState`.
- [x] Create `_runSosSequence()` asynchronous method.
- [x] Implement the Morse code loop inside `_runSosSequence()`:
    - Add checks for `!_isSosActive` and `!mounted` before every delay/flash to allow instant cancellation.
    - Implement Short flash (200ms ON, 200ms OFF).
    - Implement Long flash (600ms ON, 200ms OFF).
    - Implement gap between letters (600ms OFF).
    - Implement gap between words (1400ms OFF).
- [x] Add a `_toggleSosLight()` method to handle starting/stopping the sequence.
- [x] Handle hardware exceptions (e.g., catching `EnableTorchExcaption` or `DisableTorchException`) and showing a `SnackBar` if the flashlight is unavailable.

## 3. UI Updates (`distress-light-ui`)
- [x] Update the "SOS light" `ElevatedButton` text based on `_isSosActive` ("SOS light" vs "Stop SOS").
- [x] Update the "SOS light" `ElevatedButton` styling based on `_isSosActive` (White vs Red background, text color changes).
- [x] Connect the `onPressed` callback of the button to `_toggleSosLight()`.

## 4. Lifecycle Management
- [x] Ensure `_isSosActive` is set to `false` in the `dispose()` method of `_DistressModePageState`.
- [x] Explicitly call `TorchLight.disableTorch()` in `dispose()` to guarantee the light turns off if the user navigates away mid-flash.
- [x] Verify the slide-to-turn-off logic successfully triggers `dispose()` (it uses `Navigator.pop()`, which should trigger it, but verify no lingering async loops exist).

## 5. Testing
- [ ] Run the app on a physical Android/iOS device.
- [ ] Tap the "SOS light" button and verify the timing of the flashes (3 short, 3 long, 3 short).
- [ ] Tap "Stop SOS" while it's flashing and verify it stops immediately.
- [ ] Start the SOS light, then use the "Slide to turn off", and verify the light turns off when the screen pops.
- [ ] Run on an emulator (or iPad without flash) and verify the `SnackBar` appears without crashing.
