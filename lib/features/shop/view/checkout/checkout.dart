import 'package:flutter/material.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/product_cart/product_coupon_code.dart';
import 'package:store/common/widgets/success_screen/success_screen.dart';
import 'package:store/features/shop/view/cart/widget/cart_tem.dart';
import 'package:store/features/shop/view/checkout/widget/product_billing_address_section.dart';
import 'package:store/features/shop/view/checkout/widget/product_billing_amount_section.dart';
import 'package:store/features/shop/view/checkout/widget/product_billing_payment_section.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(TSized.defaultSpace),
        child: ElevatedButton(
            onPressed: () {
              THelperFunction.navigatedToScreen(
                  context,
                  SuccessScreen(
                    image: TImageString.paymentSuccess,
                    onPressed: () => THelperFunction.navigatedToScreenWithPop(
                      context,
                      const BottomNavigationScreen(),
                    ),
                    title: "Payment Success!",
                    subTitle: 'Your item will be shipped soon!',
                  ));
            },
            child: const Text("Checkout \$256.0")),
      ),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              // ! Items in Cart
              const CartListItem(
                isShowAddOrRemove: false,
              ),
              const SizedBox(
                height: TSized.spacebetweenSections,
              ),

              // ! Coupons TextField
              const CouponCode(),
              const SizedBox(
                height: TSized.spacebetweenSections,
              ),
              // ! Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSized.md),
                backgroundColor: isDark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    // ! Pricing
                    BillingAmountSection(),
                    SizedBox(
                      height: TSized.spacebetweenItem,
                    ),

                    // ! Divider
                    Divider(),
                    SizedBox(
                      height: TSized.spacebetweenItem,
                    ),

                    // ! payment method
                    ProductBillingPaymentSection(),
                    SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    // ! address
                    ProductBillingAddressSection(),
                    SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
