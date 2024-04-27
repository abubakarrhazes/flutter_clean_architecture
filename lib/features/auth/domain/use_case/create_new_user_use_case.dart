import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class CreateNewUserUseCase {
  final AuthRepo authRepo;
  CreateNewUserUseCase({required this.authRepo});

  Future<void> call(UserEntity user) {
    return authRepo.createNewUser(user);
  }
}
