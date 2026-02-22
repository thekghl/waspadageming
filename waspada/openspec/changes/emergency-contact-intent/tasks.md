## 1. Project Configuration

- [x] 1.1 Add `url_launcher` dependency to `pubspec.yaml` <!-- id: 1 -->
- [x] 1.2 Update Android `AndroidManifest.xml` with `<queries>` tag for `tel` and `sms` intent schemas <!-- id: 2 -->
- [x] 1.3 Update iOS `Info.plist` with `LSApplicationQueriesSchemes` array including `tel` and `sms` schemas <!-- id: 3 -->

## 2. Intent Tracking Logic

- [x] 2.1 Refactor `DistressModePage` to include an async method to launch a `tel:` Uri (e.g., to `112`) using `url_launcher`. <!-- id: 4 -->
- [x] 2.2 Implement error handling displaying a ScaffoldMessenger `SnackBar` if `canLaunchUrl` returns false. <!-- id: 5 -->
- [x] 2.3 Wire the existing "Emergency Contact" `ElevatedButton`'s `onPressed` handler to trigger this new launch method. <!-- id: 6 -->
