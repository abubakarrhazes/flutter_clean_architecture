import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/welcome_body.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              welcomeScreenBody(),
              const SizedBox(
                height: 22,
              ),
              uberAuthLoginButton()
            ],
          ),
        ),
      ),
    );
  }
}
