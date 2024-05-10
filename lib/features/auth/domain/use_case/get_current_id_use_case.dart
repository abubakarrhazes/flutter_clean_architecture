import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class GetCurrentIdUseCase {
  final AuthRepo authRepo;

  GetCurrentIdUseCase({required this.authRepo});

  Future<String> call() {
    return authRepo.getCurrentId();
  }
}
