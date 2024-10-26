import 'package:flutter/material.dart';

class UpTitle extends StatelessWidget {
  const UpTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Asiatic HRM',style: TextStyle(
              wordSpacing: 5,
              fontSize: 23,
              fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 10,),
          Text('Login first to your account',style: TextStyle(
              wordSpacing: 5,
              fontSize: 23,
              fontWeight: FontWeight.w500
          ),),
        ],
      ),
    );
  }
}