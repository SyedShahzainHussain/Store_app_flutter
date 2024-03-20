import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: TSized.spacebetweenItem,),
      itemCount: 10,
      itemBuilder: (context, index) => 
       TRoundedContainer(
        showBorder: true,
        backgroundColor: dark ? TColors.dark : TColors.light,
        padding: const EdgeInsets.all(TSized.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ! Row -> 1
            Row(
              children: [
                // ! Icon
                const Icon(Iconsax.ship),
                const SizedBox(
                  width: TSized.spacebetweenItem / 2,
                ),
                // !  2 -  Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Processing",
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: TColors.primary,
                              fontWeightDelta: 1,
                            ),
                      ),
                      Text(
                        "07 Nov 2024",
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                ),
                // ! 3 - Icon
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.arrow_right_34,
                      size: TSized.iconSm,
                    ))
              ],
            ),
            const SizedBox(height: TSized.spacebetweenItem,),
            // ! Row -> 1
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // ! Icon
                      const Icon(Iconsax.tag),
                      const SizedBox(
                        width: TSized.spacebetweenItem / 2,
                      ),
                      // !  2 -  Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order",
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                              "[#23232]",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // ! Icon
                      const Icon(Iconsax.calendar),
                      const SizedBox(
                        width: TSized.spacebetweenItem / 2,
                      ),
                      // !  2 -  Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shopping Date",
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                              "03 Feb 2025",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
