
import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';

class TCircularBorderRadius extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final Widget? child;
  final Color? backgroundColor ;

  const TCircularBorderRadius({
    super.key,
    this.width =400 ,
    this.height = 400,
    this.radius =400 ,
    this.padding = 0,
    this.child,
    this.backgroundColor = TColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: backgroundColor!.withOpacity(0.1)),
          child: child,
    );
  }
}
