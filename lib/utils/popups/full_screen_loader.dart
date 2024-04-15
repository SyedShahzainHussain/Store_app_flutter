import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/loaders/loader_animation.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: ContextUtility.navigator!.overlay!.context,
        barrierDismissible: false,
        builder: (_) => PopScope(
              canPop: false,
              child: Container(
                color: THelperFunction.isDarkMode(
                        ContextUtility.navigator!.overlay!.context)
                    ? TColors.dark
                    : TColors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimationLoaderWidget(text: text, animation: animation),
                  ],
                ),
              ),
            ));
  }

  static stopLoading() {
    Navigator.of(ContextUtility.context)
        .pop(); // Close the Dialog using the Navigator
  }
}
