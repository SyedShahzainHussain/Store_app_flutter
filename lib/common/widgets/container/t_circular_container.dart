import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';

class TCircularBorderRadius extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsets? margin;

  const TCircularBorderRadius({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.child,
    this.backgroundColor = TColors.white,
    this.margin,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!), color: backgroundColor),
      child: child,
    );
  }
}
