import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_task/custom_widget/custom_Button.dart';
import 'package:interview_task/custom_widget/custom_field.dart';
import 'package:interview_task/custom_widget/des_title.dart';
import 'package:interview_task/custom_widget/up_title.dart';
import 'package:interview_task/views/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an Email';
    }
    RegExp emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailReg.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (globalkey.currentState!.validate()) {
      try {
        // Sign in with Firebase
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passController.text,
        );

        if (userCredential.user != null) {
          // Navigate to home if login is successful
          Get.to(() => const HomaPage());
        }
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == 'user-not-found') {
          message = 'No user found with this email';
        } else if (e.code == 'wrong-password') {
          message = 'Incorrect password';
        } else {
          message = 'An error occurred. Please try again.';
        }
        Get.snackbar('Error', message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: globalkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                UpTitle(),
                SizedBox(height: 25),
                DesTitle(title: 'Email Address'),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Input your registered email',
                  onChanged: (value) {},
                  validator: _validateEmail,
                  controller: _emailController,
                ),
                SizedBox(height: 20),
                DesTitle(title: 'Password'),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Input your account password',
                  onChanged: (value) {},
                  validator: _validatePassword,
                  controller: _passController,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.check_box_outline_blank)),
                        Text(
                          'Remember me',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                CustomButton(
                  title: 'Login',
                  onTap: _submitForm,
                  backgroundColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
