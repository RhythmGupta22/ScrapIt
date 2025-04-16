import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// For loading environment variables
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:scrap_it/screens/collector/controllers/collector_profile_controller.dart';
import 'package:scrap_it/screens/login/controller/login_controller.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:scrap_it/screens/splash/views/splash_screen.dart';
import 'firebase_options.dart'; // Import the generated firebase_options.dart
import 'screens/seller/home/controllers/location_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (for non-web platforms)
  await loadEnvVariables();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthRepository()));

  // Register controllers
  Get.put(LoginController());
  Get.put(LocationController());
  Get.put(CollectorProfileController());
  // Start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(),
    );
  }
}

Future<void> loadEnvVariables() async {
  if (kIsWeb) {
    print("Web platform detected, skipping flutter_config.");
    return;
  }
  await dotenv.load(fileName: "assets/.env");
}