import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_products/fetch_products_bloc.dart';
import 'package:store/bloc/fetch_products/fetch_products_state.dart';
import 'package:store/bloc/togglelist/togglelist_bloc.dart';
import 'package:store/bloc/togglelist/togglelist_state.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/products/t_cart_products_vertical.dart';
import 'package:store/data/status/status.dart';
import 'package:store/utils/shimmer/vertical_product_shimmer.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ! Grid Layout

        BlocBuilder<FetchProductsBloc, FetchProductsState>(
          builder: (context, product) {
            return BlocBuilder<ViewModeBloc, ViewModeState>(
                builder: (context, state) {
              switch (product.status) {
                case Status.loading:
                  return const VerticalProductShimmer();
                case Status.success:
                  return GridLayout(
                      itemBuilder: (context, index) {
                        return TProductCartVertical(
                          productModel: product.products[index],
                        );
                      },
                      itemCount: product.products.length);
                case Status.failure:
                  return Text(product.message);
              }
            });
          },
        ),
      ],
    );
  }
}
