import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/check_user_status_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/create_new_user_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/get_current_id_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/is_sign_in_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_in_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:flutter_clean_architecture/features/home/presentation/pages/home_page.dart';
import 'package:get/get.dart';

class AuthControllers extends GetxController {
  final CreateNewUserUseCase createNewUserUseCase;
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentIdUseCase getCurrentIdUseCase;
  final CheckUserStatusUseCase checkUserStatusUseCase;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final showPassword = false.obs;
  var isSignIn = false.obs;
  final formKey = GlobalKey<FormState>();

  AuthControllers({
    required this.createNewUserUseCase,
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.resetPasswordUseCase,
    required this.isSignInUseCase,
    required this.getCurrentIdUseCase,
    required this.checkUserStatusUseCase,
  });

//Authentication Methods Here

  checkIsSignIn() async {
    bool authIsSignIn = await isSignInUseCase.call();
    isSignIn.value = authIsSignIn;
  }

  //Check User Status Here

  Future<bool> checkUserStatus() async {
    String userId = await getCurrentIdUseCase.call();
    return checkUserStatusUseCase.call(userId);
  }

  registerNewUser(String name, String email, String password) async {
    final userEntity = UserEntity(name: name, email: email, password: password);
    await getCurrentIdUseCase.call().then((userId) async {
      await createNewUserUseCase.call(userEntity);
      Get.snackbar("uploading details!", "Please wait !",
          showProgressIndicator: true, duration: const Duration(seconds: 10));
    });
    final userStatus = await checkUserStatus();
    if (userStatus) {
      Get.closeAllSnackbars();
      Get.snackbar("Done", "Registration Successful!");
      Get.offAll(() => const HomePage());
    }
  }
}
