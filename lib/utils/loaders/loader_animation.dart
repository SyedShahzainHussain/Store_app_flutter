import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';

class AnimationLoaderWidget extends StatelessWidget {
  /// Parameters:
  ///    - text: The text to be displayed below the animation.
  ///    - animation: The path to the Lottie animation life.

  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text, animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: MediaQuery.sizeOf(context).width * 0.8),
          const SizedBox(
            height: TSized.defaultSpace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSized.defaultSpace,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                      onPressed: onActionPressed,
                      style: OutlinedButton.styleFrom(
                        
                          backgroundColor: TColors.dark),
                      child: Text(
                        actionText!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: TColors.light),
                      )),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
