import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:scrap_it/screens/login/controller/login_controller.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:scrap_it/screens/splash/views/splash_screen.dart';
import 'screens/home/controllers/location_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loadEnvVariables();
  await Firebase.initializeApp().then((value) => Get.put(AuthRepository()));
  Get.put(LoginController());
  Get.put(LocationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  await FlutterConfig.loadEnvVariables();
}
