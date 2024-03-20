import 'package:flutter/material.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductBillingPaymentSection extends StatelessWidget {
  const ProductBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(
          title: "Payment Method",
          buttontitle: "Change",
          onPressed: () {},
        ),
        const SizedBox(height: TSized.spacebetweenItem / 2),
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: isDark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSized.sm),
              child: const Image(
                image: AssetImage(TImageString.payPal),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: TSized.spacebetweenItem / 2,
            ),
            Text(
              "Paypal",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        )
      ],
    );
  }
}
