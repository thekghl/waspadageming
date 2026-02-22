import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waspada/home_page.dart';
import 'package:waspada/services/distress_remote_service.dart';

class ApiConfig {
  // Use hackathon domain for external access
  // static const String baseUrl =
  //     'https://stygian-slumber-realm.hackathon.sev-2.com';

  // For LAN testing (same WiFi)
  static const String baseUrl = 'http://10.33.64.219:5000';

  // For emulator
  // static const String baseUrl = 'http://10.0.2.2:5000';
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Initialize Remote Distress Trigger Service
  final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'];
  if (oneSignalAppId != null && oneSignalAppId.isNotEmpty) {
    await DistressRemoteService.init(oneSignalAppId);
  } else {
    debugPrint('f785b0c0-fd41-44b1-ab2e-07f40fe30cab');
  }

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Waspada Static UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
