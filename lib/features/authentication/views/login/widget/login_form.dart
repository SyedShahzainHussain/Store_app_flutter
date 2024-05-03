import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/login/login_bloc.dart';
import 'package:store/bloc/login/login_event.dart';

import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';
import 'package:store/utils/validator/validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isObsecure = ValueNotifier<bool>(true);
  ValueNotifier<bool> isCheck = ValueNotifier<bool>(false);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetStorage localStorage = GetStorage();
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleTransition;

  @override
  void initState() {
    super.initState();
    GetStorage localStorage = GetStorage();
    emailController.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    passwordController.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    slideAnimation = Tween(begin: const Offset(-1, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    scaleTransition = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    // ! start he animation
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSized.spacebetweenSections),
        child: Column(
          children: [
            // ! Email
            SlideTransition(
              position: slideAnimation,
              child: ScaleTransition(
                scale: scaleTransition,
                child: TextFormField(
                  controller: emailController,
                  validator: (value) => TValidation.validateEmail(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.direct_right),
                    hintText: context.localizations!.email,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: TSized.spaceBtwInputFields,
            ),
            // ! Password
            SlideTransition(
              position: slideAnimation,
              child: ScaleTransition(
                scale: scaleTransition,
                child: ValueListenableBuilder(
                  valueListenable: isObsecure,
                  builder: (context, value, _) => TextFormField(
                    controller: passwordController,
                    validator: (value) =>
                        TValidation.validateEmptyText(value, TTexts.password),
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
                      hintText: context.localizations!.password,
                    ),
                  ),
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
                    Text(context.localizations!.rememberMe)
                  ],
                ),
                // ! Forget Password
                TextButton(
                    onPressed: () {
                      THelperFunction.navigatedToScreen(
                          context, RouteName.forgotPassword);
                    },
                    child: Text(context.localizations!.forgotPassword))
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
                      save();
                    },
                    child: Text(context.localizations!.signIn))),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            // ! Create Account Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      THelperFunction.navigatedToScreen(
                          context, RouteName.signUp);
                    },
                    child: Text(context.localizations!.createAccount))),
          ],
        ),
      ),
    );
  }

  void save() {
    final validate = _formKey.currentState!.validate();

    if (!validate) {
      return;
    }
    TDeviceUtils.hideKeyboard(context);
    context.read<LoginBloc>().add(LoginWithEmailAndPasswordEvent(
          emailController.text.trim(),
          passwordController.text.toString(),
          isCheck.value,
        ));
  }
}
