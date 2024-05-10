import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class CheckUserStatusUseCase {
  final AuthRepo authRepo;

  CheckUserStatusUseCase({required this.authRepo});

  Future<bool> call(String docId) async {
    return await authRepo.checkUserStatus(docId);
  }
}
