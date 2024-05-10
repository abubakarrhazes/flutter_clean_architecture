import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> resetPassword(String email);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<bool> checkUserStatus(String docId);

  //User
  Future<String> getCurrentId();
  Future<void> createNewUser(UserEntity user);
}
