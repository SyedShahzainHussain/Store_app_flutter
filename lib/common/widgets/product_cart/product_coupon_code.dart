import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: isDark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
        top: TSized.sm,
        bottom: TSized.sm,
        right: TSized.sm,
        left: TSized.md,
      ),
      child: Row(
        children: [
          // ! TextField
          const Flexible(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Have a promo code? Enter here",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          // ! Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: isDark
                        ? TColors.white.withOpacity(0.5)
                        : TColors.dark.withOpacity(0.5),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.1),
                    )),
                onPressed: () {},
                child: const Text("Apply")),
          )
        ],
      ),
    );
  }
}
