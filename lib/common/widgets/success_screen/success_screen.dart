import 'package:flutter/material.dart';
import 'package:store/common/styles/text_style_common.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';

class SuccessScreen extends StatelessWidget {
  final String title, subTitle, image;
  final VoidCallback onPressed;
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.onPressed,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TextStyleCommon.paddingWithAppBar * 2,
          child: Column(
            children: [
              // ! Image
              // LottieBuilder.asset(
              //   image,
              //   width: TDeviceUtils.screenWidth(context) * 0.6,
              // ),
              Image.asset(image),
              const SizedBox(
                height: TSized.spacebetweenSections,
              ),

              // ! Title & Subtitle

              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),

              Text(
                subTitle,
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
                  onPressed: onPressed,
                  child: Text(TTexts.continues.capitalize()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
