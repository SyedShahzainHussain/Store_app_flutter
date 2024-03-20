import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/products/rating/t_rating_indicator.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class UserRating extends StatelessWidget {
  const UserRating({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Column(
      children: [
        // ! profile of rating user
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(TImageString.userImage),
                ),
                SizedBox(
                  width: TSized.spacebetweenItem,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),
        // ! Review
        Row(
          children: [
            const RatingIndicator(
              rating: 4,
            ),
            const SizedBox(
              width: TSized.spacebetweenItem,
            ),
            Text(
              "03 March, 2024",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        const SizedBox(
          height: TSized.spacebetweenItem,
        ),
        const ReadMoreText(
          "The user inteface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great Job!",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: " show less",
          trimCollapsedText: " show more",
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
          ),
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSized.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shahzain Store",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "03 March 2024",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),
                const ReadMoreText(
                  "The user inteface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great Job!",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: " show less",
                  trimCollapsedText: " show more",
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),
      ],
    );
  }
}
