import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/add_profile_image_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/auth_otp_verification_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/auth_phone_verifcation_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/check_user_status_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/create_new_user_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/get_current_id_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/is_sign_in_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_in_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/sign_up_screen.dart';
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
  final AuthOtpVerificationUseCase authOtpVerificationUseCase;
  final AuthPhoneVerifcationUseCase authPhoneVerifcationUseCase;
  final AddProfileImageUseCase addProfileImageUseCase;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final showPassword = false.obs;
  var isSignIn = false.obs;
  var profileImgUrl =
      "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png"
          .obs;
  final formKey = GlobalKey<FormState>();

  AuthControllers({
    required this.createNewUserUseCase,
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.resetPasswordUseCase,
    required this.isSignInUseCase,
    required this.getCurrentIdUseCase,
    required this.checkUserStatusUseCase,
    required this.authOtpVerificationUseCase,
    required this.authPhoneVerifcationUseCase,
    required this.addProfileImageUseCase,
  });

//Authentication Methods Here

  checkIsSignIn() async {
    bool authIsSignIn = await isSignInUseCase.call();
    isSignIn.value = authIsSignIn;
  }

  //Check User Status Here

  Future<bool> checkUserStatus() async {
    String? userId = await getCurrentIdUseCase.call();
    return checkUserStatusUseCase.call(userId!);
  }

  //Verify User Phone Number

  verifyPhoneNumber(String phoneNumber) async {
    await authPhoneVerifcationUseCase.call(phoneNumber);
    Get.snackbar("Verifying Number", "Please wait !",
        showProgressIndicator: true, duration: const Duration(seconds: 10));
  }

  //Verify OTP Sent

  verifyOtp(String otp) async {
    Get.snackbar("Validating Otp", "Please wait !",
        showProgressIndicator: true, duration: const Duration(seconds: 10));
    await authOtpVerificationUseCase.call(otp).whenComplete(() async {
      String userId = await getCurrentIdUseCase.call();
      if (userId.isNotEmpty) {
        Get.closeAllSnackbars();
        final userStatus = await checkUserStatus();
        if (userStatus) {
          Get.offAll(() => const HomePage());
        } else {
          Get.offAll(() => const SignUpScreen());
        }
      }
    });
  }

  //Pick Profile Image Here

  pickProfileImg() async {
    String userId = await getCurrentIdUseCase.call();
    String profileUrl = await addProfileImageUseCase.call(userId);
    Get.snackbar("please wait", "Uploading Image....");
    profileImgUrl.value = profileUrl;
  }

  //Register A New User

  registerNewUser(String name, String email, String password) async {
    final userEntity = UserEntity(
      name: name,
      email: email,
      password: password,
    );
    print(userEntity);
    await getCurrentIdUseCase.call().then((userId) async {
      await createNewUserUseCase(
        userEntity,
      );
      Get.snackbar("Creating Account!", "Please wait !",
          showProgressIndicator: true, duration: const Duration(seconds: 10));
    });
    final userStatus = await checkUserStatus();
    print(userStatus);
    if (userStatus) {
      Get.closeAllSnackbars();
      Get.snackbar("Done", "Registration Successful!");
      Get.offAll(() => const HomePage());
    }
  }

  loginUser(String email, String password) async {
    final userEntity = UserEntity(email: email, password: password);
    await getCurrentIdUseCase.call().then((userId) async {
      await signInUseCase.call(userEntity);
    });
    final userStatus = await checkUserStatus();
    if (userStatus) {
      Get.closeAllSnackbars();
      Get.snackbar("Done", "Log In Successful!");
      Get.offAll(() => const HomePage());
    }
  }
}
