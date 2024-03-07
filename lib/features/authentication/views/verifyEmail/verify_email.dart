import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store/common/widgets/success_screen/success_screen.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/helper/helper_function.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

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
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              // ! Image
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

              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              Text(
                "ABC@gmail.com",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSized.spacebetweenSections,
              ),

              // ! Button

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    THelperFunction.navigatedToScreen(
                      context,
                      SuccessScreen(
                        image: TImageString.verifiedImage,
                        onPressed: () {
                          THelperFunction.navigatedToScreenWithPop(
                              context, const Login());
                        },
                        title: TTexts.yourAccountCreatedTitle,
                        subTitle: TTexts.yourAccountCreatedSubTitle,
                      ),
                    );
                  },
                  child: Text(TTexts.continues.capitalize()),
                ),
              ),

              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
