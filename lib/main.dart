import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:store/app.dart';
import 'package:store/bloc_provider.dart';
import 'package:store/features/authentication/controller/on_board_controller.dart';
import 'package:store/firebase_options.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/network/network_manager.dart';

Future<void> main() async {
  // ! Widget Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  // ! Device Orientation
  TDeviceUtils.setPreferredOrientation([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // ! load get Storage
  await GetStorage.init();
  // ! Await splash screen until items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // ! intiliazed firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ! check intenet
  NetworkManager();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnBoardController(),
        ),
      ],
      child: const BlocProviders(child: MyApp()),
    ),
  );
}
