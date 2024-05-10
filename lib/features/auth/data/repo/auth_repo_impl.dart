import 'package:flutter_clean_architecture/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<void> createNewUser(UserEntity user) async =>
      await authRemoteDataSource.createNewUser(user);

  @override
  Future<String> getCurrentId() async {
    // TODO: implement getCurrentId
    return await authRemoteDataSource.getCurrentId();
  }

  @override
  Future<bool> isSignIn() async {
    return await authRemoteDataSource.isSignIn();
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity user) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(UserEntity user) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<bool> checkUserStatus(String docId) async {
    return await authRemoteDataSource.checkUserStatus(docId);
  }
}
