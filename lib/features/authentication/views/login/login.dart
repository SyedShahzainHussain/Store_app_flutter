import 'package:flutter/material.dart';
import 'package:store/common/styles/text_style_common.dart';
import 'package:store/common/widgets/login_signup/login_divider.dart';
import 'package:store/common/widgets/login_signup/social_button.dart';
import 'package:store/features/authentication/views/login/widget/login_form.dart';
import 'package:store/features/authentication/views/login/widget/login_title.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/helper/helper_function.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TextStyleCommon.paddingWithAppBar,
          child: Column(
            children: [
              // ! logo and title subtitle
              const LoginTitle(),

              // ! Form
              const LoginForm(),

              // ! Divider
              LoginDivider(isDark: isDark,title: TTexts.orSignInWith,),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              // ! social button
              const SoicalButton()
            ],
          ),
        ),
      ),
    );
  }
}
