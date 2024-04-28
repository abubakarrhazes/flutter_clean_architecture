import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/create_new_user_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_in_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:get/get.dart';

class AuthControllers extends GetxController {
  final CreateNewUserUseCase createNewUserUseCase;
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final showPassword = false.obs;
  final formKey = GlobalKey<FormState>();

  AuthControllers(
      {required this.createNewUserUseCase,
      required this.signUpUseCase,
      required this.signInUseCase,
      required this.resetPasswordUseCase});

//Authentication Methods Here
}
