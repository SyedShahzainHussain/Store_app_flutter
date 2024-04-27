import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/favourite/favourite_bloc.dart';
import 'package:store/bloc/favourite/favourite_event.dart';
import 'package:store/bloc/favourite/favourite_state.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/icons/t_circular_icons.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/products/t_cart_products_vertical.dart';
import 'package:store/data/status/status.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/loaders/loader_animation.dart';
import 'package:store/utils/shimmer/vertical_product_shimmer.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(GetFavourite());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          THelperFunction.isDarkMode(context) ? TColors.black : TColors.white,
      appBar: CustomAppBar(
        title: Text(
        context.localizations!.wishList,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcons(
            icon: Iconsax.add,
            onPressed: () => THelperFunction.navigatedToScreenWithPop(
                context, const BottomNavigationScreen()),
          )
        ],
      ),
      body: PopScope(
         canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          THelperFunction.navigatedToScreenWithPop(
              context, const BottomNavigationScreen());
        }
      },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: BlocBuilder<FavouriteBloc, FavouriteState>(
              builder: (context, state) {
                switch (state.status) {
                  case Status.loading:
                    return const VerticalProductShimmer();
                  case Status.failure:
                    return Column(
                      children: [
                        Center(
                          child: Text(state.message),
                        ),
                      ],
                    );
                  case Status.success:
                    return state.whishListProducts.isEmpty
                        ? Column(
                            children: [
                              Center(
                                child: AnimationLoaderWidget(
                                  text: context.localizations!.wishListIsEmpty,
                                  animation: TImageString.wishList,
                                  showAction: true,
                                  actionText:context.localizations!.letAddSome,
                                  onActionPressed: () {
                                    THelperFunction.navigatedToScreen(
                                        context, const BottomNavigationScreen());
                                  },
                                ),
                              )
                            ],
                          )
                        : GridLayout(
                            itemBuilder: (_, index) => TProductCartVertical(
                                  productModel: state.whishListProducts[index],
                                ),
                            itemCount: state.whishListProducts.length);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
