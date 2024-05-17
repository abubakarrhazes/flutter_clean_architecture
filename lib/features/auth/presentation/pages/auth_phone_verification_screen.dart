// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_constructors, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:country_picker/country_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/logic/auth_controllers.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_phone_widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthPhoneVerificationScreen extends StatefulWidget {
  const AuthPhoneVerificationScreen({super.key});

  @override
  State<AuthPhoneVerificationScreen> createState() =>
      _AuthPhoneVerificationScreenState();
}

class _AuthPhoneVerificationScreenState
    extends State<AuthPhoneVerificationScreen> {
  final AuthControllers authControllers = Get.find();
  final TextEditingController _phoneAuthController = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: "+234",
      countryCode: "NGN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Nigeria",
      example: "Nigeria",
      displayName: "Nigeria",
      displayNameNoCountryCode: "NGN",
      e164Key: "");

  @override
  void dispose() {
    _phoneAuthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              buildStaticPhoneVerificationPageBody(),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneAuthController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    countryListTheme: CountryListThemeData(
                                      bottomSheetHeight: 550,
                                    ),
                                    onSelect: (value) {
                                      setState(() {
                                        selectedCountry = value;
                                        print(selectedCountry);
                                      });
                                    });
                              },
                              // ignore: unnecessary_string_interpolations
                              child: Text('${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}'),
                            )),
                        suffixIcon: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_phoneAuthController.text.isNotEmpty &&
                              _phoneAuthController.text.length == 10) {
                            authControllers.verifyPhoneNumber(
                                "${selectedCountry.phoneCode}" + _phoneAuthController.text);
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Send',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
