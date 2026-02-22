# Design: SOS Flashlight

## Overview
The SOS flashlight feature will enable users to broadcast a visual distress signal using the device's camera flashlight. The signal will follow the standard Morse code pattern for SOS (3 short flashes, 3 long flashes, 3 short flashes). The feature will be accessible via the `DistressModePage` and will run asynchronously until explicitly turned off or until the distress mode is exited.

## Architecture & Approach

### 1. Flashlight Control Plugin
We will use the `torch_light` package. It is a simple, actively maintained Flutter plugin specifically designed to turn the device flashlight on and off.
- **Why `torch_light`?**: It is lightweight and focuses solely on the flashlight capability without pulling in the heavy dependencies of the full `camera` package.

### 2. SOS Sequence Logic (Blinker)
The blinking logic will be encapsulated in a new service or directly within the `DistressModePage` state.
- **Pattern**:
    - Short flash (Dot): 200ms ON
    - Long flash (Dash): 600ms ON
    - Gap between flashes: 200ms OFF
    - Gap between letters (S, O, S): 600ms OFF
    - Gap between words (repeating the sequence): 1400ms OFF
- **Asynchronous Execution**: The sequence will be executed in an infinite `while` loop inside an `async` function. 
- **Cancellation**: A boolean flag (e.g., `_isSosActive`) will be checked before every flash to ensure the sequence can be stopped immediately when the user toggles the button or exits the page.

### 3. UI State Management (`DistressModePage`)
- A new state variable `bool _isSosActive = false;` will track the current state.
- The "SOS light" button will toggle this state.
- **Visual Feedback**: The button's text or color will change based on the state. For example:
    - Inactive: White button, Red text ("SOS light").
    - Active: Red button with white border, White text ("Stop SOS light") or a flashing animation.

### 4. Lifecycle & Error Handling
- **Dispose**: The blinking loop must check `mounted` and the cancellation flag to avoid memory leaks or flashlight-on states after the user leaves the page.
- **Errors**: `torch_light` can throw exceptions if the device has no flashlight. We must catch these and show a `SnackBar` to the user informing them that the flashlight feature is unavailable.

## State Management
State will be managed locally within `_DistressModePageState` using `setState()`. Since the feature is localized to this specific page, local state management is sufficient and avoids over-engineering.

## Error Handling
```dart
try {
  final isTorchAvailable = await TorchLight.isTorchAvailable();
  if (!isTorchAvailable) {
    // Show SnackBar: "Senter tidak didukung di perangkat ini."
    return;
  }
  // Proceed with turning on/off
} catch (e) {
  // Catch PlatformException or other errors
  // Show SnackBar: "Gagal menggunakan senter: $e"
}
```

## Testing Strategy
- **Manual Device Testing**: This feature must be tested on physical Android and iOS devices, as the Android Emulator and iOS Simulator typically do not emulate the flashlight hardware.
- Test cases:
    1. Toggle on: Verify the SOS Morse code pattern is correct.
    2. Toggle off: Verify the sequence stops immediately and the flashlight turns off.
    3. Navigation: Slide to turn off distress mode while the flashlight is blinking; verify the flashlight turns off.
    4. Unsupported device: Run on a simulator or device without a flashlight to verify the error SnackBar appears gracefully.
