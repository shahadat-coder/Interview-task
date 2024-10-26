import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool? isSecured;
  final Widget? trailing;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator; // Add validator parameter
  final  TextEditingController? controller; // Add validator parameter

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isSecured,
    this.trailing,
    this.onChanged,
    this.validator,
    this.controller,  // Initialize validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isSecured == true ? true : false,
      validator: validator, // Use the validator function
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.black,
                width: 0.2
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(
                color: Colors.green,
                width: 1.5
            )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(
                color: Colors.black,
                width: 0.5
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 0.5
            )
        ),
        hintText: hintText,
        suffixIcon: trailing,
      ),
    );
  }
}
