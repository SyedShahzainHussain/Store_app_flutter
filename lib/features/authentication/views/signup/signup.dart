import 'package:flutter/material.dart';
import 'package:store/common/widgets/login_signup/login_divider.dart';
import 'package:store/common/widgets/login_signup/social_button.dart';
import 'package:store/features/authentication/views/signup/widget/sign_up_button.dart';
import 'package:store/features/authentication/views/signup/widget/sign_up_form.dart';
import 'package:store/features/authentication/views/signup/widget/sign_up_privacy.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/helper/helper_function.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! title
              Text(
                TTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSized.spacebetweenSections,
              ),

              // ! Form
              const SignUpForm(),

              // ! Terms and conditions
              SignUpPrivacy(isDark: isDark),
              const SizedBox(height: TSized.spacebetweenItem),
              // ! Sign up button
              const SignUpButton(),

              // ! Divider
              const SizedBox(height: TSized.spacebetweenItem),
              LoginDivider(isDark: isDark, title: TTexts.orSignupWith),
              const SizedBox(height: TSized.spacebetweenItem),
              // ! social button
              const SoicalButton()
            ],
          ),
        ),
      ),
    );
  }
}
