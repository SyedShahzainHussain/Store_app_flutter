import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/products/t_cart_products_vertical.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:
            THelperFunction.isDarkMode(context) ? TColors.black : TColors.white,
      appBar: CustomAppBar(
        title: Text(
          "WishList",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcons(
            icon: Iconsax.add,
            onPressed: () => THelperFunction.navigatedToScreenWithPop(
                context, const BottomNavigationScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: GridLayout(
              itemBuilder: (_, index) => const TProductCartVertical(),
              itemCount: 8),
        ),
      ),
    );
  }
}
