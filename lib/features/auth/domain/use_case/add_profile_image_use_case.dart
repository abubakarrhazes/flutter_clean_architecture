import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class AddProfileImageUseCase {
  final AuthRepo authRepo;

  AddProfileImageUseCase({required this.authRepo});

  Future<String> call(String userId) async {
    return await authRepo.addProfileImg(userId);
  }
}
