# Spec: Distress Light UI

## Overview
The `distress-light-ui` capability manages the user interface elements on the `DistressModePage` that interact with the SOS flashlight feature, including the toggle button state and error notifications.

## States & Transitions
- **Toggle Off (Default)**: The SOS sequence is not running. The button says "SOS light" and has a white background with red text.
- **Toggle On**: The SOS sequence is running. The button says "Stop SOS" and has a red background with a white border.
- **Transition `onTogglePressed`**: If currently Off, attempt to start the `sos-blinker`. If it starts successfully, update state to On. If currently On, stop the blinker and update state to Off.

## Core Rules
1.  **Visual Distinction**: The active state must look substantially different from the inactive state to clearly indicate the distress signal is broadcasting.
2.  **Graceful Degradation**: If the hardware check fails (no flashlight), the button state should remain Off, and a `SnackBar` must be shown to the user.
3.  **Lifecycle Integration**: When the user slides the "Slide to turn off" control and the page is popped, the `distress-light-ui` must guarantee that a stop signal is sent to `sos-blinker`.

## Edge Cases
-   **Double Taps**: Rapidly tapping the "SOS light" button shouldn't spawn multiple concurrent blinking loops. The UI state must reflect the processing or simply debounce the action.
-   **Page Dismissal**: Navigating back via system back gestures (if allowed) or the slide-to-off button MUST cleanly shut down the flashlight. The `dispose()` method in the `State` class is vital here.
