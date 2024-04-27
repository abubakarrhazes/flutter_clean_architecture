import '../../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource{


  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> resetPassword(String email);
  Future<bool> isSignIn();
  Future<void> signOut();

  //User
  Future<String> getCurrentId();
  Future<void> createNewUser(UserEntity user);







}