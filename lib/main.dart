
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:interview_task/views/auth/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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


