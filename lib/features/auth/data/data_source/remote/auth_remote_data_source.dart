import '../../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> resetPassword(String email);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<bool> checkUserStatus(String docId);

  Future<void> authPhoneVerification(String phoneNumber);

  Future<void> authOtpVerification(String otp);
  Future<String> addProfileImg(String userId);

  //User
  Future<String> getCurrentId();
  Future<void> createNewUser(UserEntity user);
}
