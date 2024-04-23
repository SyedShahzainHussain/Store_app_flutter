import 'package:store/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductCartAddAndRemoveButton extends StatelessWidget {
  final int quantity;
  final VoidCallback? add, remove;
  const ProductCartAddAndRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcons(
          onPressed: remove,
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
        Text(quantity.toString()),
        const SizedBox(
          width: TSized.spacebetweenItem,
        ),
        TCircularIcons(
          onPressed: add,
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
