import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store/common/widgets/network/network_screen.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/global_context/context_utils.dart';

class NetworkManager {
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  NetworkManager() {
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(
      ConnectivityResult connectivityResult) async {
    _connectivityResult = connectivityResult;
    if (_connectivityResult == ConnectivityResult.none) {
      // ! no Internet
      TDeviceUtils.hideKeyboard(ContextUtility.navigator!.overlay!.context);
      Navigator.pushAndRemoveUntil(
          ContextUtility.navigator!.overlay!.context,
          MaterialPageRoute(builder: (_) => const NetworkScreen()),
          (route) => false);
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  dispose() {
    _connectivitySubscription.cancel();
  }
}
