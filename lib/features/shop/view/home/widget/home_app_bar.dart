import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/product_cart/product_cart_widget.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';
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
            context.localizations!.homeAppBarTitle,
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
        IconButton(
          onPressed: () {
            THelperFunction.navigatedToScreen(context, RouteName.chatBotScreen);
          },
          icon: Container(
            padding: const EdgeInsets.all(TSized.xsm),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: TColors.accent,
            ),
            child: Image.asset(
              TImageString.chatBotImage,
              width: 30,
              height: 30,
            ),
          ),
        ),
        ProductCartWidget(
          color: TColors.white,
          onPressed: () {
            THelperFunction.navigatedToScreen(context, RouteName.cartScreen);
          },
        ),
      ],
    );
  }
}
