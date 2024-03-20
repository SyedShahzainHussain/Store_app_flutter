import 'package:flutter/material.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/products/rating/t_rating_indicator.dart';
import 'package:store/features/shop/view/product_rating/widget/t_overall_product_rating.dart';
import 'package:store/features/shop/view/product_rating/widget/t_user_rating.dart';

import 'package:store/utils/constants/size.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Reviews & Rating"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and reviews are verified and are from people who use the same type of device that you use.",
              ),
              const SizedBox(
                height: TSized.defaultSpace,
              ),
              // ! Overall Product Ratings
              const OverAllProductRating(),
              const RatingIndicator(
                rating: 3.5,
              ),
              Text(
                "13,411",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              const UserRating(),
              const UserRating(),
            ],
          ),
        ),
      ),
    );
  }
}
