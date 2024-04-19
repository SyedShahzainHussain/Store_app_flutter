import 'package:flutter/material.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/size.dart';

class ProductBillingAddressSection extends StatelessWidget {
  const ProductBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: "Shopping Address",
          buttontitle: "Change",
          onPressed: () {},
        ),
        Text(
          "Syed Shahzain",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: TSized.spacebetweenItem / 2),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(
              width: TSized.spacebetweenItem,
            ),
            Text(
              "+92-317-2122123",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(
          width: TSized.spacebetweenItem / 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_history,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(
              width: TSized.spacebetweenItem,
            ),
            Flexible(
              child: Text(
                "South Karachi Mayien 332323,Pakistan",
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
              ),
            ),
          ],
        )
      ],
    );
  }
}
