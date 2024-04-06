import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ! SubTotal  fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subtotal",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$256.0",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: TSized.spacebetweenItem /2,),
        // ! Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shipping Fee",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$6.0",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
                const SizedBox(height: TSized.spacebetweenItem /2,),
        // ! Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax Fee",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$14.0",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
                const SizedBox(height: TSized.spacebetweenItem /2,),
        // ! Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Total",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$323.0",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
                const SizedBox(height: TSized.spacebetweenItem /2,),
      ],
    );
  }
}
