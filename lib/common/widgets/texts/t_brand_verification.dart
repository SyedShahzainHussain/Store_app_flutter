import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/texts/t_brand_title.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/size.dart';

class TBrandTitleAndVerification extends StatelessWidget {
  const TBrandTitleAndVerification({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            maxLines: maxLines,
            color: textColor,
            textAlign: textAlign,
            textSizes: brandTextSize,
          ),
        ),
        const SizedBox(
          width: TSized.sm,
        ),
        const Icon(
          Iconsax.verify5,
          color: TColors.primary,
          size: TSized.iconXsm,
        ),
        
      ],
    );
  }
}
