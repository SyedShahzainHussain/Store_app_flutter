import 'package:flutter/material.dart';
import 'package:store/common/widgets/chip/t_chip.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Column(children: [
      // ! Selected Attribute Pricing & Description

      TRoundedContainer(
        padding: const EdgeInsets.all(TSized.md),
        backgroundColor: dark ? TColors.darkGrey : TColors.grey,
        child: Column(
          children: [
            // ! Title , Price and Stock Status
            Row(
              children: [
                TSectionHeading(
                  title: "Variation",
                  showActionButton: false,
                ),
                const SizedBox(
                  width: TSized.spacebetweenItem,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TProductTitle(
                          title: "Price : ",
                          smallSize: true,
                        ),

                        // ! Actual Price
                        Text(
                          "\$25",
                          style: Theme.of(context).textTheme.titleSmall!.apply(
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                        const SizedBox(
                          width: TSized.spacebetweenItem,
                        ),
                        const TProductPriceText(price: "20")
                      ],
                    ),
                    Row(
                      children: [
                        const TProductTitle(
                          title: "Stock : ",
                          smallSize: true,
                        ),
                        Text(
                          "In Stock",
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // ! Variation Description
            const TProductTitle(
              title:
                  "This is the description of the product and it can go up to max 4 lines",
              smallSize: true,
              maxLines: 4,
            ),
          ],
        ),
      ),

      const SizedBox(
        height: TSized.spacebetweenItem,
      ),

      // ! Attributes
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(
            title: "Colors",
            showActionButton: false,
          ),
          const SizedBox(
            height: TSized.spacebetweenItem / 2,
          ),
          Wrap(
            spacing: 8,
            children: [
              TChoiceChip(
                text: "green",
                selected: true,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: "blue",
                selected: true,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: "yellow",
                selected: false,
                onSelected: (value) {},
              ),
            ],
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(
            title: "Size",
            showActionButton: false,
          ),
          const SizedBox(
            height: TSized.spacebetweenItem / 2,
          ),
          Wrap(
            spacing: 8,
            children: [
              TChoiceChip(
                text: "EU 34",
                selected: true,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: "EU 36",
                selected: false,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: "EU 38",
                selected: true,
                onSelected: (value) {},
              ),
            ],
          )
        ],
      )
    ]);
  }
}
