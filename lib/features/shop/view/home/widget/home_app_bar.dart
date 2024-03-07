
import 'package:flutter/material.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/product_cart/product_cart_widget.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/texts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Text(
            TTexts.homeAppBarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.white),
          ),
        ],
      ),
      actions: [
        ProductCartWidget(
          color: TColors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
