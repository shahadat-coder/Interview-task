import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:interview_task/views/auth/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyD59FhIfx5TvO1rGMRnXStY0j9UfZ1Qekg',
          appId: "1:958078582401:android:79ded660824b7174ba5780",
          messagingSenderId: '',
          projectId: "login-register-firebase-cfea0"));
  runApp(const LoginAndRegister());
}

class LoginAndRegister extends StatelessWidget {
  const LoginAndRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowMaterialGrid: false,
      title: "Firebase Demo",
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}
