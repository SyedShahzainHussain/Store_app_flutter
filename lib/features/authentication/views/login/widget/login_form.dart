import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/features/authentication/views/forgotpassword/forgot_password.dart';
import 'package:store/features/authentication/views/signup/signup.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/helper/helper_function.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isObsecure = ValueNotifier<bool>(true);
    ValueNotifier<bool> isCheck = ValueNotifier<bool>(false);

    return Form(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSized.spacebetweenSections),
        child: Column(
          children: [
            // ! Email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                hintText: TTexts.email,
              ),
            ),
            const SizedBox(
              height: TSized.spaceBtwInputFields,
            ),
            // ! Password
            ValueListenableBuilder(
              valueListenable: isObsecure,
              builder: (context, value, _) => TextFormField(
                obscuringCharacter: "*",
                obscureText: isObsecure.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObsecure.value ? Iconsax.eye_slash : Iconsax.eye),
                    onPressed: () {
                      isObsecure.value = !isObsecure.value;
                    },
                  ),
                  hintText: TTexts.password,
                ),
              ),
            ),
            const SizedBox(
              height: TSized.spaceBtwInputFields / 2,
            ),

            // ! Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ! Remember Me
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isCheck,
                      builder: (context, value, child) => Checkbox(
                        value: isCheck.value,
                        onChanged: (value) {
                          isCheck.value = !isCheck.value;
                        },
                      ),
                    ),
                    const Text(TTexts.rememberMe)
                  ],
                ),
                // ! Forget Password
                TextButton(
                    onPressed: () {
                      THelperFunction.navigatedToScreen(
                          context, const ForgotPassword());
                    },
                    child: const Text(TTexts.forgotPassword))
              ],
            ),
            const SizedBox(
              height: TSized.spacebetweenSections,
            ),
            // ! Sign in Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      THelperFunction.navigatedToScreen(
                          context, const BottomNavigation());
                    },
                    child: const Text(TTexts.signIn))),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            // ! Create Account Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      THelperFunction.navigatedToScreen(
                          context, const SignUp());
                    },
                    child: const Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
