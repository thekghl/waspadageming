import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../distress_mode_page.dart';

class DistressRemoteService {
  static Future<void> init(String appId) async {
    // Basic validation: OneSignal App IDs are UUIDs (8-4-4-4-12 chars)
    // Google/Firebase keys usually start with 'AIza'
    if (appId.startsWith('AIza') || appId.length < 30) {
      debugPrint(
        '⚠️ WARNING: The provided ID looks like an API Key, not a OneSignal App ID.',
      );
      debugPrint(
        'Please use the App ID (UUID) from OneSignal Dashboard > Settings > Keys & IDs.',
      );
      return;
    }

    try {
      // Debug Logging
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

      // Initialize OneSignal
      OneSignal.initialize(appId);

      // Request permissions
      OneSignal.Notifications.requestPermission(true);

      // Register Handlers
      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        debugPrint(
          'Notification received in foreground: ${event.notification.additionalData}',
        );
        _handleNotificationData(event.notification.additionalData);
      });

      OneSignal.Notifications.addClickListener((event) {
        debugPrint(
          'Notification clicked: ${event.notification.additionalData}',
        );
        _handleNotificationData(event.notification.additionalData);
      });

      // Observer for subscription changes (SDK 5.0+)
      // The ID is often null immediately at init, so we listen for when it's assigned.
      OneSignal.User.pushSubscription.addObserver((state) {
        final id = OneSignal.User.pushSubscription.id;
        if (id != null) {
          debugPrint('--- ONESIGNAL READY ---');
          debugPrint('OneSignal Player ID: $id');
          debugPrint('------------------------');
        }
      });

      // Initial check
      final initialId = OneSignal.User.pushSubscription.id;
      if (initialId != null) {
        debugPrint('OneSignal Player ID (at init): $initialId');
      }
    } catch (e) {
      debugPrint('❌ OneSignal Init Error: $e');
    }
  }

  static void _handleNotificationData(Map<String, dynamic>? data) {
    if (data == null) return;

    if (data['type'] == 'distress_trigger') {
      debugPrint('Distress signal detected. Overriding UI...');

      // Check if we are already in DistressModePage to avoid double-push
      final context = navigatorKey.currentContext;
      if (context != null) {
        bool isAlreadyInDistress = false;
        Navigator.popUntil(context, (route) {
          if (route.settings.name == '/distress') {
            isAlreadyInDistress = true;
          }
          return true;
        });

        if (isAlreadyInDistress) {
          debugPrint('Already in Distress Mode. Skipping push.');
          return;
        }
      }

      // Use the global navigator key to push the DistressModePage
      // We use push because the user might want to dismiss it later
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          settings: const RouteSettings(name: '/distress'),
          builder: (context) => DistressModePage(),
        ),
      );
    }
  }
}
