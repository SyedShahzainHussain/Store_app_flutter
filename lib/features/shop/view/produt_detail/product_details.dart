import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/features/shop/view/produt_detail/widget/product_image_slider.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_product_meta_data.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_rating_share.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ! 1- Product Image Slider
            ProductImageSlider(),
            // ! 2- Product Details
            Padding(
              padding: EdgeInsets.only(
                right: TSized.defaultSpace,
                left: TSized.defaultSpace,
                bottom: TSized.defaultSpace,
              ),
              child: Column(
                children: [
                  // ! Rating & Share Button
                  TRatingShare(),
                  // ! Price , Title ,Stocks & Brand
                  TProductMetaData(),
                  // ! Atributes
                  // ! Checkout Button
                  // ! Description
                  // ! Reviews
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
