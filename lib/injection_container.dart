import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_clean_architecture/core/network/network_checker_controller.dart';
import 'package:flutter_clean_architecture/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/auth/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:flutter_clean_architecture/features/auth/data/repo/auth_repo_impl.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/check_user_status_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/create_new_user_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/get_current_id_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/is_sign_in_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_in_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/domain/use_case/sign_up_use_case.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/logic/auth_controllers.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await netWorkServiceLocator();
  await authServiceLocator();
}

//Network Checker Service Locator
Future<void> netWorkServiceLocator() async {
  sl.registerFactory<NetworkCheckerController>(
      () => NetworkCheckerController());
}

//Auth Service Locator
Future<void> authServiceLocator() async {
  //Register GetXController Here
  sl
    ..registerFactory<AuthControllers>(() => AuthControllers(
        createNewUserUseCase: sl.call(),
        signUpUseCase: sl.call(),
        signInUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        getCurrentIdUseCase: sl.call(),
        checkUserStatusUseCase: sl.call(),
        resetPasswordUseCase: sl.call()))

    //Register Use Case
    ..registerLazySingleton<CreateNewUserUseCase>(
        () => CreateNewUserUseCase(authRepo: sl.call()))
    ..registerLazySingleton<SignInUseCase>(
        () => SignInUseCase(authRepo: sl.call()))
    ..registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(authRepo: sl.call()))
    ..registerLazySingleton<ResetPasswordUseCase>(
        () => ResetPasswordUseCase(authRepo: sl.call()))
    ..registerLazySingleton<IsSignInUseCase>(
        () => IsSignInUseCase(authRepo: sl.call()))
    ..registerLazySingleton<GetCurrentIdUseCase>(
        () => GetCurrentIdUseCase(authRepo: sl.call()))
    ..registerLazySingleton<CheckUserStatusUseCase>(
        () => CheckUserStatusUseCase(authRepo: sl.call()))
    //Register Repository
    ..registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(authRemoteDataSource: sl.call()))

    //Register Data Source
    ..registerLazySingleton<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImpl(
            firebaseAuth: sl.call(),
            firebaseStorage: sl.call(),
            firebaseFireStore: sl.call()))

    // Register Externals
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
