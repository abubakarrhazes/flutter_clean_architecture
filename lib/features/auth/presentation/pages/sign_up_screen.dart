// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/logic/auth_controllers.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_sign_up_body_widget.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

final AuthControllers authControllers = Get.find();

@override
void dispose() {
  nameController.dispose();
  emailController.dispose();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(''),
                    //FileImage(_profileImage!),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          //_uberAuthController.pickProfileImg();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
              authRegisterPageBody(
                  authControllers.nameController,
                  authControllers.emailController,
                  authControllers.passwordController),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        GetUtils.isEmail(emailController.text)) {
                      authControllers.registerNewUser(nameController.text,
                          emailController.text, passwordController.text);
                    } else {
                      Get.snackbar("error", "invalid values!");
                    }
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
