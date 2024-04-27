import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/add_order/add_order_bloc.dart';
import 'package:store/bloc/add_order/add_order_event.dart';
import 'package:store/bloc/add_order/add_order_state.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_state.dart';
import 'package:store/bloc/selected_address/selected_bloc.dart';
import 'package:store/bloc/selected_payment/selected_payment_bloc.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/product_cart/product_coupon_code.dart';
import 'package:store/common/widgets/success_screen/success_screen.dart';
import 'package:store/features/shop/model/order_model/order_model.dart';
import 'package:store/features/shop/view/cart/widget/cart_item.dart';
import 'package:store/features/shop/view/checkout/widget/product_billing_address_section.dart';
import 'package:store/features/shop/view/checkout/widget/product_billing_amount_section.dart';
import 'package:store/features/shop/view/checkout/widget/product_billing_payment_section.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/helper/pricing_calculator.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: BlocBuilder<CartItemBloc, CartItemState>(
        builder: (context, state) {
          final totalAmount = PricingCalculator.calculatedTotalAmount(
              state.totalCartPrice, "US");
          return Container(
            margin: const EdgeInsets.all(TSized.defaultSpace),
            child: ElevatedButton(
                onPressed: totalAmount > 0
                    ? () {
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        final OrderModel orderModel = OrderModel(
                          id: UniqueKey().toString(),
                          status: OrderStatus.pending,
                          items: state.cartItem,
                          totalAmount: totalAmount,
                          orderDate: DateTime.now(),
                          addressModel: context
                              .read<SelectedAddressBloc>()
                              .state
                              .isAddressSeleted,
                          deliveryDate: DateTime.now(),
                          paymentMethod: context
                              .read<SelectedPaymentBloc>()
                              .state
                              .paymentModel!
                              .name,
                          userId: userId,
                        );
                        context
                            .read<AddOrderBloc>()
                            .add(AddOrder(orderModel, userId));
                      }
                    : () {
                        THelperFunction.showDelightToast(
                            "Empty Cart! Add items in the cart in order to procees",
                            Icons.error,
                            Colors.red);
                      },
                child: Text("Checkout \$$totalAmount")),
          );
        },
      ),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          context.localizations!.orderReview,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocListener<AddOrderBloc, AddOrderState>(
          listener: (context, state) {
            if (state is AddOrdersLoadingState) {
              TFullScreenLoader.openLoadingDialog(
                "Processing your order...",
                TImageString.loaderJson,
              );
            } else if (state is AddOrdersErrorState) {
              THelperFunction.showDelightToast(
                  state.message, Icons.error, Colors.red);
            } else {
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
              THelperFunction.showDelightToast("Your Order Has Been Sent");
            }
          },
          child: SingleChildScrollView(
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
          )),
    );
  }
}
