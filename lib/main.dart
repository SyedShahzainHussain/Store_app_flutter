import 'package:flutter/material.dart';
import 'package:store/app.dart';
import 'package:provider/provider.dart';
import 'package:store/features/authentication/controller/onBoard_controller.dart';
import 'package:store/features/shop/controller/home_controller.dart';

void main() {
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
      child: const MyApp(),
    ),
  );
}
