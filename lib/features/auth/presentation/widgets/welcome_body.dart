import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/auth_phone_verification_screen.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget welcomeScreenBody() {
  return Column(
    children: [
      Image.asset(
        'assets/images/3.jpg',
        width: 240,
        fit: BoxFit.contain,
        height: 300,
      ),
      const SizedBox(
        height: 18,
      ),
      const Text(
        "Let's get started",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Expand Your Food Experience with Foodie.",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black38,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 38,
      ),
    ],
  );
}

Widget uberAuthLoginButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        Get.to(() => const AuthPhoneVerificationScreen());
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14.0),
        child: Text(
          'Get Started',
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
  );
}
