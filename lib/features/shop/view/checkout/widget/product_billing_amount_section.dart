import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/pricing_calculator.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemBloc, CartItemState>(
      builder: (context, state) {
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
                  "\$${state.totalCartPrice}",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: TSized.spacebetweenItem / 2,
            ),
            // ! Shipping fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Fee",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "\$${PricingCalculator.calculatedShippingCost(state.totalCartPrice, "Us")}",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: TSized.spacebetweenItem / 2,
            ),
            // ! Tax fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tax Fee",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "\$${PricingCalculator.calculatedTax(state.totalCartPrice, "Us")}",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: TSized.spacebetweenItem / 2,
            ),
            // ! Order Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order Total",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "\$${PricingCalculator.calculatedTotalAmount(state.totalCartPrice, "Us")}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: TSized.spacebetweenItem / 2,
            ),
          ],
        );
      },
    );
  }
}
