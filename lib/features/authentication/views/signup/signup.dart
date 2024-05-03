import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/register/register_bloc.dart';
import 'package:store/bloc/register/register_state.dart';
import 'package:store/common/widgets/login_signup/login_divider.dart';
import 'package:store/common/widgets/login_signup/social_button.dart';

import 'package:store/features/authentication/views/signup/widget/sign_up_form.dart';
import 'package:store/features/authentication/views/verifyEmail/verify_email.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';

import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<RegisterBloc, RegisterState>(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ! title
                Text(
                  context.localizations!.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSized.spacebetweenSections,
                ),

                // ! Form
                const SignUpForm(),

                // ! Divider
                const SizedBox(height: TSized.spacebetweenItem),
                LoginDivider(
                    isDark: isDark, title: context.localizations!.orSignupWith),
                const SizedBox(height: TSized.spacebetweenItem),
                // ! social button
                const SoicalButton(),
              ],
            ),
          ),
        ),
        listener: (context, state) {
          if (state is RegisterInitialLoading) {
            TFullScreenLoader.openLoadingDialog(
              "We are processing your information...",
              TImageString.loaderJson,
            );
          } else if (state is RegisterNetworkError) {
            THelperFunction.showDelightToast(
                "Network Error! Please check your internet connection.");
          } else if (state is RegisterDone) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => VerifyEmail(
                          email: state.email,
                        )));
            THelperFunction.showDelightToast(
                "Register Successfully", Iconsax.copy_success, Colors.green);
          } else if (state is RegisterError) {
            THelperFunction.showDelightToast(
                'Error: ${state.error}', Icons.error, Colors.red);
          }
        },
      ),
    );
  }
}
