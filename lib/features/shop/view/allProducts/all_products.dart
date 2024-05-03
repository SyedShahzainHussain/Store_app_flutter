import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/all_products/all_product_bloc.dart';
import 'package:store/bloc/all_products/all_product_event.dart';
import 'package:store/bloc/all_products/all_product_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/products/sortable_products.dart';
import 'package:store/data/status/status.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/shimmer/vertical_product_shimmer.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    super.initState();
    context.read<AllProductBloc>().add(GetAllProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: Text(context.localizations!.popularProducts),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: BlocBuilder<AllProductBloc, AllProductState>(
              builder: (context, state) {
                switch (state.status) {
                  case Status.loading:
                    return const VerticalProductShimmer(
                      itemCount: 6,
                    );
                  case Status.failure:
                    return Center(
                      child: Text(state.message),
                    );
                  case Status.success:
                    return state.productModel.isEmpty
                        ?  Center(
                            child: Text(context.localizations!.noProducts),
                          )
                        : SortableProducts(
                            productModel: state.productModel,
                          );
                }
              },
            )),
      ),
    );
  }
}
