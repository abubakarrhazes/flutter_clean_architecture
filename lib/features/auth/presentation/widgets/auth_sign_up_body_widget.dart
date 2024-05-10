import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_text_field.dart';

Widget authRegisterPageBody(TextEditingController name,
    TextEditingController email, TextEditingController password) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        child: const Text(
          "Let's start with creating your account",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      TextFieldWidget(
        labelText: 'Full Name*',
        textType: 'Enter your name',
        inputType: TextInputType.text,
        controller: name,
      ),
      //Spacer(),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Email Address',
        textType: 'Enter your email',
        inputType: TextInputType.emailAddress,
        controller: email,
      ),

      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Password*',
        textType: 'Enter your password here',
        inputType: TextInputType.text,
        controller: password,
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
