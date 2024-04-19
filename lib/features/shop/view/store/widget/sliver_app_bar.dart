import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/brand/brand_bloc.dart';
import 'package:store/bloc/brand/brand_state.dart';
import 'package:store/common/widgets/brands/brands_porducts.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/text_field_container/text_field_container.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/view/allBrands/all_brands.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/shimmer/brand_shimmer.dart';

class SliverApp extends StatelessWidget {
  final PreferredSizeWidget preferredSizeWidget;
  const SliverApp({
    super.key,
    required this.preferredSizeWidget
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        floating: true,
        backgroundColor:
            THelperFunction.isDarkMode(context) ? TColors.black : TColors.white,
        expandedHeight: 440,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              // ! Search Bar
              const TTextFieldContainer(
                text: "Serarch in Store",
                showBackGround: false,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              // ! Feature Brands
              TSectionHeading(
                title: "Featured Brands",
                onPressed: () {
                  THelperFunction.navigatedToScreen(
                      context, const AllBrandsScreen());
                },
              ),
              const SizedBox(
                height: TSized.spacebetweenItem / 1.5,
              ),
              BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.loading:
                      return const BrandShimmer();
                    case Status.failure:
                      return Center(
                        child: Text(state.message),
                      );
                    case Status.success:
                      return GridLayout(
                        mainAxisExtent: 80,
                        itemBuilder: (context, index) {
                          return FeatureBrandGridWidget(
                            id: state.featuredBrand[index].id ?? "",
                            image: state.featuredBrand[index].image!.isNotEmpty
                                ? state.featuredBrand[index].image!
                                : TImageString.adidasIcon,
                            title: state.featuredBrand[index].name ?? "",
                            subTitle:
                                "${state.featuredBrand[index].productCount.toString()} Products",
                            onTap: () {
                              THelperFunction.navigatedToScreen(
                                context,
                                BrandsProducts(
                                  brandModel: state.featuredBrand[index],
                                ),
                              );
                            },
                            showBorder: true,
                            isNetworkImage:
                                state.featuredBrand[index].image!.isNotEmpty,
                          );
                        },
                        itemCount: state.featuredBrand.length,
                      );
                  }
                },
              )
            ],
          ),
        ),
        bottom: preferredSizeWidget);
  }
}
