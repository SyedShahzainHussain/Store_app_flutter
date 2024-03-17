
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/curved/curvedWidget.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
     final dark = THelperFunction.isDarkMode(context);
    return CurvedWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            // ! Main Large Image
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSized.productImageRadius * 2),
                child: Image(
                  image: AssetImage(TImageString.product1),
                ),
              ),
            ),
            // ! Image Slider
            Positioned(
                right: 0,
                bottom: 30,
                left: TSized.defaultSpace,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(
                      width: TSized.spacebetweenItem,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) => TRoundedImage(
                      width: 80,
                      backgroundColor:
                          dark ? TColors.dark : TColors.white,
                      border: Border.all(color: TColors.primary),
                      padding: const EdgeInsets.all(TSized.sm),
                      imageUrl: TImageString.product1,
                    ),
                  ),
                )),
            // ! Appbar Icons
            const CustomAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcons(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
