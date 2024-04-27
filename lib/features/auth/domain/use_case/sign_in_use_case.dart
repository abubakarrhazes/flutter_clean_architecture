import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class SignInUseCase {
  final AuthRepo authRepo;

  SignInUseCase({required this.authRepo});

  Future<void> call(UserEntity user) {
    return authRepo.signIn(user);
  }
}
