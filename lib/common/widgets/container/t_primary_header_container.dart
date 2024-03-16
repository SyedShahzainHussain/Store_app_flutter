import 'package:flutter/material.dart';
import 'package:store/common/widgets/container/clip_behaviour.dart';
import 'package:store/common/widgets/container/t_circular_container.dart';
import 'package:store/utils/constants/colors.dart';

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
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: TCircularBorderRadius(
                  backgroundColor: TColors.white.withOpacity(0.1),
                )),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularBorderRadius(
                    backgroundColor: TColors.white.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
