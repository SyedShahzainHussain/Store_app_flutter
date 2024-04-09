import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:store/bloc/forgot_password/forgot_password_state.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/features/authentication/views/reset_screen/widget/reset_button.dart';
import 'package:store/features/authentication/views/reset_screen/widget/reset_title.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/helper/helper_function.dart';

class ResetScreen extends StatelessWidget {
  final String email;
  const ResetScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              THelperFunction.navigatedToScreenWithPop(context, const Login());
            },
            icon: const Icon(
              CupertinoIcons.clear,
            ),
          )
        ],
      ),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            THelperFunction.showDelightToast(state.message);
          } else if (state is ForgotPasswordSuccess) {
            THelperFunction.showDelightToast("Forgot Password Email Send",
                Iconsax.copy_success, Colors.green);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Column(
              children: [
                Image(
                  width: TDeviceUtils.screenWidth(context) * 0.6,
                  image: const AssetImage(
                    TImageString.deleiveredImage,
                  ),
                ),
                const SizedBox(
                  height: TSized.spacebetweenSections,
                ),

                Text(
                  THelperFunction.hideCentralCharacterEmail(email),
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSized.sm,
                ),
                // ! Title & Subtitle

                const ResetTitleSubTitle(),

                const SizedBox(
                  height: TSized.spacebetweenSections,
                ),
                // ! Button

                ResetButton(email: email),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
