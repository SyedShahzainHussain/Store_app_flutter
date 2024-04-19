import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store/bloc/brand_products/brand_products_bloc.dart';
import 'package:store/bloc/brand_products/brand_products_event.dart';
import 'package:store/bloc/brand_products/brand_products_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/products/sortable_products.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/shimmer/vertical_product_shimmer.dart';

class BrandsProducts extends StatefulWidget {
  final BrandModel brandModel;
  const BrandsProducts({super.key, required this.brandModel});

  @override
  State<BrandsProducts> createState() => _BrandsProductsState();
}

class _BrandsProductsState extends State<BrandsProducts> {
  @override
  void initState() {
    context
        .read<BrandProductsBloc>()
        .add(GetSpecificBrandProducts(widget.brandModel.id ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(widget.brandModel.name ?? ""),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              FeatureBrandGridWidget(
                id: widget.brandModel.id!,
                image: widget.brandModel.image!,
                title: widget.brandModel.name!,
                subTitle: widget.brandModel.productCount.toString(),
                onTap: () => {},
                showBorder: true,
                isNetworkImage: widget.brandModel.image!.isNotEmpty,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              BlocBuilder<BrandProductsBloc, BrandProductsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.loading:
                      return const VerticalProductShimmer();
                    case Status.failure:
                      return Center(child: Text(state.message));
                    case Status.success:
                      return state.brandProducts.isEmpty
                          ? const Center(
                              child: Text("No Products Found"),
                            )
                          : SortableProducts(
                              productModel: state.brandProducts,
                            );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
