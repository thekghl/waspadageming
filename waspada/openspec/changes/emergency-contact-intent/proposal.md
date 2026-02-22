## Why

During an emergency, users need a rapid, frictionless way to contact emergency services or predefined personal emergency contacts directly from the Distress Mode screen and the Home Page Dropdown. Currently, the "Emergency SOS" button is a static UI element that performs no action. To fulfill the life-saving purpose of the Waspada application, this button must seamlessly open the device's native dialer or SMS application using Android Intents to quickly bridge the gap between the app and the physical authorities.

## What Changes

- Introduce the `url_launcher` dependency to the project to handle launching external URLs and intents.
- Wire the existing "Emergency SOS" buttons in `DistressModePage` and `HomeDropdownMenu` to execute a `tel:` intent.
- Set up a predefined emergency number (e.g., `112` for Indonesia's National Emergency Number, or a configurable contact) that is passed to the intent.
- Implement error handling to alert the user if the device cannot launch the dialer intent (e.g., tablet without SIM capabilities).
- Update the iOS `Info.plist` with `LSApplicationQueriesSchemes` to whitelist `tel` and `sms` URLs.

## Capabilities

### New Capabilities
- `emergency-intent`: The ability for the application to invoke system-level intents to place phone calls or send text messages outside of the app environment.

### Modified Capabilities
- `static-ui`: The passive Emergency SOS buttons will be upgraded to an active trigger for the native dialer intent.

## Impact

- **Dependencies**: Adds the `url_launcher` package to the project ecosystem to handle deep link and intent routing.
- **Platform Integrity**: Requires modifying Android/iOS native configuration files (`Info.plist` and `AndroidManifest.xml` via intents query) to explicitly declare the intent schemas (`tel` and `sms`) used by the app to respect modern OS security models.
