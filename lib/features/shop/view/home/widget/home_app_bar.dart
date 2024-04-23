import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/product_cart/product_cart_widget.dart';
import 'package:store/features/shop/view/cart/cart.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          BlocBuilder<FetchUserBloc, FetchUserState>(
            builder: (context, state) {
              if (state is FetchUserLoaded) {
                return Text(
                  state.user?.fullName ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: TColors.white),
                );
              } else {
                return const ShimmerEffect(width: 80, height: 15);
              }
            },
          ),
        ],
      ),
      actions: [
        ProductCartWidget(
          color: TColors.white,
          onPressed: () {
            THelperFunction.navigatedToScreen(context, const CartScreen());
          },
        ),
      ],
    );
  }
}
