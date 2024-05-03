import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/brand_products/brand_products_bloc.dart';
import 'package:store/bloc/brand_products/brand_products_event.dart';
import 'package:store/bloc/brand_products/brand_products_state.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';
import 'package:store/utils/shimmer/boxex_shimmer.dart';
import 'package:store/utils/shimmer/list_tile_shimmer.dart';

class TBrandShowCase extends StatefulWidget {
  final BrandModel brandModel;
  const TBrandShowCase({super.key, required this.brandModel});

  @override
  State<TBrandShowCase> createState() => _TBrandShowCaseState();
}

class _TBrandShowCaseState extends State<TBrandShowCase> {
  @override
  void initState() {
    super.initState();
    context
        .read<BrandProductsBloc>()
        .add(GetSpecificBrandProducts(widget.brandModel.id!));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => THelperFunction.navigatedToScreen(
          context, RouteName.brandsProducts,
          arguments: widget.brandModel),
      child: TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSized.md),
        margin: const EdgeInsets.only(bottom: TSized.spacebetweenItem),
        child: Column(
          children: [
            // ! Brand With Product Count
            FeatureBrandGridWidget(
              id: widget.brandModel.id!,
              image: widget.brandModel.image!,
              title: widget.brandModel.name!,
              subTitle: widget.brandModel.productCount.toString(),
              onTap: () => THelperFunction.navigatedToScreen(
                  context, RouteName.brandsProducts,
                  arguments: widget.brandModel),
              showBorder: false,
              isNetworkImage: widget.brandModel.image!.isNotEmpty,
            ),

            const SizedBox(
              height: TSized.spacebetweenItem,
            ),

            // ! Brand Top 3 Products Images
            BlocBuilder<BrandProductsBloc, BrandProductsState>(
              builder: (context, state) {
                switch (state.status) {
                  case Status.loading:
                    return const Column(
                      children: [
                        ListTileShimmer(),
                        SizedBox(
                          height: TSized.spacebetweenItem,
                        ),
                        BoxesShimmer(),
                        SizedBox(
                          height: TSized.spacebetweenItem,
                        ),
                      ],
                    );
                  case Status.failure:
                    return Center(
                      child: Text(state.message),
                    );
                  case Status.success:
                    return Row(
                      children: state.brandProducts
                          .map((category) =>
                              brandWidget(category.thumbnail, context))
                          .toList(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Expanded brandWidget(String image, BuildContext context) {
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(TSized.md),
      margin: const EdgeInsets.only(right: TSized.sm),
      backgroundColor: THelperFunction.isDarkMode(context)
          ? TColors.darkerGrey
          : TColors.light,
      child: image.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: image,
            )
          : const Image(
              fit: BoxFit.contain,
              image: AssetImage(TImageString.product1),
            ),
    ),
  );
}
