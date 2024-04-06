import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/app.dart';
import 'package:provider/provider.dart';
import 'package:store/bloc/authentication/authentication_bloc.dart';
import 'package:store/bloc/authentication/authentication_events.dart';
import 'package:store/bloc/login/login_bloc.dart';
import 'package:store/bloc/register/register_bloc.dart';
import 'package:store/bloc/verification/verification_bloc.dart';
import 'package:store/features/authentication/controller/onBoard_controller.dart';
import 'package:store/features/shop/controller/home_controller.dart';
import 'package:store/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/utils/network/network_manager.dart';

Future<void> main() async {
  // ! Widget Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        )
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                AuthenticationBloc()..add(CheckAuthentication())),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => VerificationBloc()),
        BlocProvider(create: (context) => LoginBloc()),
      ], child: const MyApp()),
    ),
  );
}
