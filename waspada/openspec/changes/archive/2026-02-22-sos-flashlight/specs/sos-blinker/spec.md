# Spec: SOS Blinker

## Overview
The `sos-blinker` capability manages the low-level logic of turning the device's flashlight on and off in a standard Morse code SOS pattern asynchronously.

## States & Transitions
- **Idle**: The flashlight is off, and no sequence is running.
- **Blinking**: The flashlight is toggling on and off according to the SOS sequence parameters.
- **Transition `startSequence`**: Moves from Idle to Blinking.
- **Transition `stopSequence`**: Moves from Blinking to Idle. Cancels the active loop and ensures the flashlight is off.
- **Error**: Represents a state where the `torch_light` package throws an exception (e.g., no flashlight available). The caller will catch this.

## Core Rules
1.  **Morse Code Timing**:
    -   Unit length (arbitrary base, e.g., 200ms).
    -   Dot (short flash): 1 unit (200ms) ON.
    -   Dash (long flash): 3 units (600ms) ON.
    -   Intra-character gap (between dots/dashes of same letter): 1 unit (200ms) OFF.
    -   Inter-character gap (between the S, O, and S): 3 units (600ms) OFF.
    -   Word gap (between full SOS sequences): 7 units (1400ms) OFF.
2.  **Safety**: The sequence must be cancellable at any point during any delay.
3.  **Hardware Independence**: Needs to cleanly handle cases where `TorchLight.enableTorch()` throws an error (e.g., on an iPad without a flash or an emulator).

## Edge Cases
-   **Immediate Cancellation**: If the user presses "Stop" during a 1400ms delay, the light should not turn on again.
-   **Missing Hardware**: Device does not have a flashlight. `TorchLight.isTorchAvailable()` returns false, or `enableTorch()` throws.
-   **Backgrounding**: If the app goes to the background, `torch_light` behavior might vary by OS. The sequence loop should continue but might throw platform exceptions if the camera is claimed by the OS. Catch all exceptions inside the loop to avoid unhandled async errors.
