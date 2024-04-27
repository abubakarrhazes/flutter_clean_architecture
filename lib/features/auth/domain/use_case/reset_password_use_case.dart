import '../repo/auth_repo.dart';

class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase({required this.authRepo});

  Future<void> call(String email) {
    return authRepo.resetPassword(email);
  }
}
