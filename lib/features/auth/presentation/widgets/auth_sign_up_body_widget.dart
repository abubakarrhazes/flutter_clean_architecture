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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Full Name Required';
          }
          return '';
        },
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
        validator: (value) {
          RegExp emailRegExp = RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

          if (value == null || value.isEmpty) {
            return 'Email can\'t be empty';
          } else if (!emailRegExp.hasMatch(value)) {
            return 'Enter a correct email';
          }
          return '';
        },
      ),

      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Password*',
        textType: 'Enter your password here',
        inputType: TextInputType.text,
        controller: password,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password Required';
          }
          return '';
        },
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget authLoginPageBody(
    TextEditingController email, TextEditingController password) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        child: const Text(
          "Login to your account",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Email Address',
        textType: 'Enter your email',
        inputType: TextInputType.emailAddress,
        controller: email,
        validator: (value) {
          RegExp emailRegExp = RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

          if (value == null || value.isEmpty) {
            return 'Email can\'t be empty';
          } else if (!emailRegExp.hasMatch(value)) {
            return 'Enter a correct email';
          }
          return '';
        },
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Password*',
        textType: 'Enter your password here',
        inputType: TextInputType.text,
        controller: password,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password Required';
          }
          return '';
        },
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
