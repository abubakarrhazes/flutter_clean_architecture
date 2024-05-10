import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class IsSignInUseCase {
  final AuthRepo authRepo;

  IsSignInUseCase({required this.authRepo});

  Future<bool> call() async {
    return await authRepo.isSignIn();
  }
}
