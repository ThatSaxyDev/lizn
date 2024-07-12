import 'package:flutter/material.dart';
import 'package:lizn/core/utils/extensions.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      // style: Elevated,
      child: 'Get Started'.txt16(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
