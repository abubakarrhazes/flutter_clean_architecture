import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_clean_architecture/core/network/network_checker.dart';
import 'package:get/get.dart';

class NetworkCheckerController extends GetxController{

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  var isNetworkAvl = false.obs;

  updateConnectionStatus() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
          if (result == ConnectivityResult.none) {
            Get.dialog(const NetworkChecker());
          } else {
            isNetworkAvl.value = true;
            bool? isDialogOpen = Get.isDialogOpen;
            if (isDialogOpen == true) {
              Get.back();
            }
          }
        });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }







}