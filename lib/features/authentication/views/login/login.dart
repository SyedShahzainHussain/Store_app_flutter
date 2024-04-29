import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/google/google_bloc.dart';
import 'package:store/bloc/google/google_state.dart';
import 'package:store/bloc/login/login_bloc.dart';
import 'package:store/bloc/login/login_state.dart';
import 'package:store/bottom_navigation/bottom_navigtion.dart';
import 'package:store/common/styles/text_style_common.dart';
import 'package:store/common/widgets/login_signup/login_divider.dart';
import 'package:store/common/widgets/login_signup/social_button.dart';
import 'package:store/features/authentication/views/login/widget/login_form.dart';
import 'package:store/features/authentication/views/login/widget/login_title.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';

import 'package:store/utils/extension/language.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/helper/helper_function.dart';

import 'package:store/utils/popups/full_screen_loader.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {
                TFullScreenLoader.openLoadingDialog(
                  "We are processing your information...",
                  TImageString.loaderJson,
                );
              } else if (state is LoginError) {
                THelperFunction.showDelightToast(
                    state.message, Icons.error, Colors.red);
              } else {
                final user = FirebaseAuth.instance.currentUser;
                if (user!.emailVerified) {
                  if (ContextUtility.context.mounted) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>  BottomNavigationScreen()),
                        (route) => false);

                    THelperFunction.showDelightToast(
                        "Login Success", Iconsax.copy_success, Colors.green);
                  }
                } else {
                  THelperFunction.showDelightToast("Verify Your Account",
                      Iconsax.copy_success, Colors.green);
                }
              }
            },
          ),
          BlocListener<GoogleAuthBloc, GoogleAuthState>(
            listener: (context, state) {
              if (state is GoogleAuthLoading) {
                TFullScreenLoader.openLoadingDialog(
                  "Logging you in...",
                  TImageString.loaderJson,
                );
              } else if (state is GoogleAuthError) {
                THelperFunction.showDelightToast(
                    state.error, Icons.error, Colors.red);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>  BottomNavigationScreen()),
                    (route) => false);
                THelperFunction.showDelightToast(
                    "Login Success", Iconsax.copy_success, Colors.green);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: TextStyleCommon.paddingWithAppBar,
            child: Column(
              children: [
                // ! logo and title subtitle
                const LoginTitle(),

                // ! Form
                const LoginForm(),

                // ! Divider
                LoginDivider(
                  isDark: isDark,
                  title: context.localizations!.orSignInWith,
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),
                // ! social button
                const SoicalButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
