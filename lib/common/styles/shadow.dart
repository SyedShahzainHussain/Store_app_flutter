import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 5,
    spreadRadius: 1,
    offset: const Offset(0,2)
  );
}
