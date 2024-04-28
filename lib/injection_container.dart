import 'dart:ffi';

import 'package:flutter_clean_architecture/core/network/network_checker_controller.dart';
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
  sl.registerFactory<AuthControllers>(() => AuthControllers(
      createNewUserUseCase: sl.call(),
      signUpUseCase: sl.call(),
      signInUseCase: sl.call(),
      resetPasswordUseCase: sl.call()));

  //Register Use Case

  //Register Repository

  //Register Data Source
}
