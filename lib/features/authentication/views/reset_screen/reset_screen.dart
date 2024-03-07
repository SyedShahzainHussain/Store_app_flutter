import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/features/authentication/views/reset_screen/widget/reset_button.dart';
import 'package:store/features/authentication/views/reset_screen/widget/reset_title.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/helper/helper_function.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

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
      body: SingleChildScrollView(
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

              // ! Title & Subtitle

              const ResetTitleSubTitle(),

              const SizedBox(
                height: TSized.spacebetweenSections,
              ),
              // ! Button

              const ResetButton(),
            ],
          ),
        ),
      ),
    );
  }
}
