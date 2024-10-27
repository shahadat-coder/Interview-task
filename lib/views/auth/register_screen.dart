import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/custom_widget/custom_Button.dart';
import 'package:interview_task/custom_widget/des_title.dart';
import 'package:interview_task/custom_widget/up_title.dart';
import 'package:interview_task/firebase_services/firebase-auth-services.dart';
import 'package:interview_task/views/auth/login.dart';
import '../../custom_widget/custom_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  String  name = "",email = "",phone = "", password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailReg.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      String userName = _nameController.text.trim();
      String emailAddress = _emailController.text.trim();
      String phoneNumber = _phoneController.text.trim();
      String password = _passController.text.trim();

      try {
        print('Attempting sign up...');
        User? user = await _auth.signUpWithEmailAndPassword(
          userName,
          emailAddress,
          phoneNumber,
          password,
        );

        if (user != null) {
          Get.to(() => const LoginScreen());
        } else {
          Get.snackbar('Error', 'Sorry! Unable to sign up');
        }
      } catch (e) {
        print('Sign up error: $e');
        Get.snackbar('Sign Up Error', e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const UpTitle(),
                  const SizedBox(height: 25),
                  const DesTitle(title: 'Enter your Name'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Input your name',
                    validator: _validateName,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
                  const DesTitle(title: 'Email Address'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Input your email',
                    validator: _validateEmail,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  const DesTitle(title: 'Phone Number'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Input your number',
                    validator: _validatePhone,
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 20),
                  const DesTitle(title: 'Password'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Input new password',
                    validator: _validatePassword,
                    controller: _passController,
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    title: 'Sign Up',
                    onTap: _signUp, // Directly calling _signUp method
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
