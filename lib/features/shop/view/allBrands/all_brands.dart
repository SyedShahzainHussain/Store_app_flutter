import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/brand/brand_bloc.dart';
import 'package:store/bloc/brand/brand_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/brands/brands_porducts.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/data/status/status.dart';

import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/shimmer/brand_shimmer.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Brands"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              // ! Heading
              TSectionHeading(
                title: "Brands",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              // ! Brands
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
                            id: state.allBrand[index].id ?? "",
                            image: state.allBrand[index].image!.isNotEmpty
                                ? state.allBrand[index].image!
                                : TImageString.adidasIcon,
                            title: state.allBrand[index].name ?? "",
                            subTitle:
                                "${state.allBrand[index].productCount.toString()} Products",
                            onTap: () => THelperFunction.navigatedToScreen(
                              context,
                              BrandsProducts(
                                brandModel: state.allBrand[index],
                              ),
                            ),
                            showBorder: true,
                            isNetworkImage:
                                state.allBrand[index].image!.isNotEmpty,
                          );
                        },
                        itemCount: state.allBrand.length,
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
