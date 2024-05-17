import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class AuthOtpVerificationUseCase {
  final AuthRepo authRepo;

  AuthOtpVerificationUseCase({required this.authRepo});

  Future<void> call(String otp) async {
    return await authRepo.authOtpVerification(otp);
  }
}
