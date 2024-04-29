import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/authentication/authentication_bloc.dart';
import 'package:store/bloc/authentication/authentication_state.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/features/authentication/views/onboarding/onboarding.dart';
import 'package:store/features/authentication/views/verifyEmail/verify_email.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_bloc.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_state.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.appLocale,
          debugShowCheckedModeBanner: false,
          navigatorKey: ContextUtility.navigatorKey,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), //* English
            Locale('ur'), //* Urdu
          ],
          title: 'Store App',
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationInitialState) {
                return const Scaffold(
                  backgroundColor: Colors.blue,
                  body: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                );
              } else if (state is AuthenticatedVerified) {
                return const BottomNavigationScreen();
              } else if (state is UnAuthenticatedVerified) {
                return VerifyEmail(
                  email: FirebaseAuth.instance.currentUser?.email ?? "",
                );
              } else if (state is OnBoardAuthenticatedState) {
                return const Login();
              } else {
                return const OnBoard();
              }
            },
          ),
        );
      },
    );
  }
}
