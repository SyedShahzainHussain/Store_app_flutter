import 'package:flutter/material.dart';
import 'package:store/common/widgets/container/clip_behaviour.dart';
import 'package:store/common/widgets/container/t_circular_container.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/device/devices_utility.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipBehavior(),
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        height: TDeviceUtils.screenHeight(context) / 2,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: -150, right: -250, child: TCircularBorderRadius(backgroundColor: TColors.white.withOpacity(0.1),)),
             Positioned(
                top: 100, right: -300, child: TCircularBorderRadius(backgroundColor: TColors.white.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
