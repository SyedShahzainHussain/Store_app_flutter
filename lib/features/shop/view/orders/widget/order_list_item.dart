import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/fetch_orders/fetch_orders_bloc.dart';
import 'package:store/bloc/fetch_orders/fetch_orders_event.dart';
import 'package:store/bloc/fetch_orders/fetch_orders_state.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/data/status/status.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/loaders/loader_animation.dart';

class OrderListItems extends StatefulWidget {
  const OrderListItems({super.key});

  @override
  State<OrderListItems> createState() => _OrderListItemsState();
}

class _OrderListItemsState extends State<OrderListItems> {
  @override
  void initState() {
    super.initState();
    context.read<FetchOrderBloc>().add(FetchOrder());
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return BlocBuilder<FetchOrderBloc, FetchOrderState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(
              child: TRoundedContainer(
                padding: EdgeInsets.all(12),
                width: 50,
                height: 50,
                backgroundColor: TColors.primary,
                showBorder: true,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeCap: StrokeCap.round,
                  strokeWidth: 3.0,
                ),
              ),
            );
          case Status.failure:
            return Center(child: Text(state.message.toString()));
          case Status.success:
            return state.orderList.isEmpty
                ? Center(
                child: AnimationLoaderWidget(
                  text: context.localizations!.orderIsEmpty,
                  animation: TImageString.noOrders,
                  showAction: true,
                  actionText: context.localizations!.letOrderIt,
                  onActionPressed: () {
                    THelperFunction.navigatedToScreen(
                        context, const BottomNavigationScreen());
                  },
                ),
              )
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    itemCount: state.orderList.length,
                    itemBuilder: (context, index) => TRoundedContainer(
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
                                      state.orderList[index].orderStatusText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .apply(
                                            color: TColors.primary,
                                            fontWeightDelta: 1,
                                          ),
                                    ),
                                    Text(
                                      THelperFunction.formatDeliveryDate(
                                          state.orderList[index].deliveryDate!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
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
                          const SizedBox(
                            height: TSized.spacebetweenItem,
                          ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(context.localizations!.order,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium),
                                          Text(
                                            state.orderList[index].id,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(context.localizations!.shoppingData,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium),
                                          Text(
                                            THelperFunction.formatDeliveryDate(
                                                state.orderList[index]
                                                    .orderDate),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
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
      },
    );
  }
}
