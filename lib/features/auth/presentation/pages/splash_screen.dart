import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/network/network_checker_controller.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/logic/auth_controllers.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/welcome_screen.dart';
import 'package:flutter_clean_architecture/features/home/presentation/pages/home_page.dart';
import 'package:flutter_clean_architecture/injection_container.dart' as di;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthControllers authControllers = Get.put(di.sl<AuthControllers>());
  final NetworkCheckerController networkCheckerController =
      Get.put(di.sl<NetworkCheckerController>());

  @override
  void initState() {
    networkCheckerController.updateConnectionStatus();
    authControllers.checkIsSignIn();
    Timer(const Duration(seconds: 3), () async {
      if (authControllers.isSignIn.value) {
        if (await authControllers.checkUserStatus()) {
          Get.off(() => const HomePage());
        } else {
          Get.off(() => const SignUpScreen());
        }
      } else {
        Get.off(() => const WelcomeScreen());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Text(
        "FOODIE",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 45),
      )),
    );
  }
}
