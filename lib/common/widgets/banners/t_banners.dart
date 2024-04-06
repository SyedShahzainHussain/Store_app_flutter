import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:store/common/widgets/container/t_circular_container.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/features/shop/controller/home_controller.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';

class TBanners extends StatelessWidget {
  const TBanners({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, value, _) => Column(
        children: [
          CarouselSlider(
            items: const [
              TRoundedImage(imageUrl: TImageString.promoBanner1),
              TRoundedImage(imageUrl: TImageString.promoBanner2),
              TRoundedImage(imageUrl: TImageString.promoBanner3),
            ],
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, _) => value.setIndex(index),
            ),
          ),
          const SizedBox(
            height: TSized.spacebetweenItem,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i <= 2; i++)
                  TCircularBorderRadius(
                    width: 20,
                    height: 4,
                    backgroundColor: value.currentIndex == i
                        ? TColors.primary
                        : TColors.grey,
                    margin: const EdgeInsets.only(right: 5),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
