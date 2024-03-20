import 'package:store/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductCartAddAndRemoveButton extends StatelessWidget {
  const ProductCartAddAndRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcons(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          iconSize: TSized.md,
          color: THelperFunction.isDarkMode(context)
              ? TColors.white
              : TColors.black,
          backgroundColor: THelperFunction.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSized.spacebetweenItem,
        ),
        const Text("2"),
        const SizedBox(
          width: TSized.spacebetweenItem,
        ),
        const TCircularIcons(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          iconSize: TSized.md,
          color: TColors.white,
          backgroundColor: TColors.primary,
        )
      ],
    );
  }
}
