import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class AuthPhoneVerifcationUseCase {
  final AuthRepo authRepo;

  AuthPhoneVerifcationUseCase({required this.authRepo});

  Future<void> call(String phoneNumber) async {
    return await authRepo.authPhoneVerification(phoneNumber);
  }
}
