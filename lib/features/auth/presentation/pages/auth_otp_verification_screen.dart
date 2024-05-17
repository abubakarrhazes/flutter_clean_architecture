import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/logic/auth_controllers.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_otp_widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthOtpVerificationScreen extends StatefulWidget {
  const AuthOtpVerificationScreen({super.key});

  @override
  State<AuthOtpVerificationScreen> createState() =>
      _AuthOtpVerificationScreenState();
}

class _AuthOtpVerificationScreenState extends State<AuthOtpVerificationScreen> {
  final TextEditingController code1 = TextEditingController();
  final TextEditingController code2 = TextEditingController();
  final TextEditingController code3 = TextEditingController();
  final TextEditingController code4 = TextEditingController();
  final TextEditingController code5 = TextEditingController();
  final TextEditingController code6 = TextEditingController();
  final AuthControllers authControllers = Get.find();

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
              const SizedBox(
                height: 20,
              ),
              buildStaticOtpVerificationBody(),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        textFieldOTP(
                            first: true,
                            last: false,
                            context: context,
                            textEditingController: code1),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code2),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code3),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code4),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code5),
                        textFieldOTP(
                            first: false,
                            last: true,
                            context: context,
                            textEditingController: code6),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String otp = code1.text +
                              code2.text +
                              code3.text +
                              code4.text +
                              code5.text +
                              code6.text;
                          authControllers.verifyOtp(otp);
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
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              buildBottomOtpVerificationBody()
            ],
          ),
        ),
      ),
    );
  }
}
