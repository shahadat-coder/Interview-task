import 'package:flutter/material.dart';

class DesTitle extends StatelessWidget {
  final String title;
  const DesTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(
      wordSpacing: 5,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),);
  }
}