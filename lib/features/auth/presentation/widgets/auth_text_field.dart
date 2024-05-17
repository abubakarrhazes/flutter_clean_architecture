import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String textType;
  final TextInputType inputType;
  final TextEditingController? controller;
  final String Function(String?)? validator;

  const TextFieldWidget(
      {Key? key,
      required this.labelText,
      required this.textType,
      required this.inputType,
      required this.controller,
      this.validator
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
