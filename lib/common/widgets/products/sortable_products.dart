import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/all_products/all_product_bloc.dart';
import 'package:store/bloc/all_products/all_product_event.dart';
import 'package:store/bloc/all_products/all_product_state.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/products/t_cart_products_vertical.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/utils/constants/size.dart';

class SortableProducts extends StatefulWidget {
  final List<ProductModel> productModel;
  const SortableProducts({super.key, required this.productModel});

  @override
  State<SortableProducts> createState() => _SortableProductsState();
}

class _SortableProductsState extends State<SortableProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      context
          .read<AllProductBloc>()
          .add(SortProducts(null, widget.productModel));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductBloc, AllProductState>(
      builder: (context, state) {
        return Column(
          children: [
            // ! Dropdown
            DropdownButtonFormField<String?>(
                decoration:
                    const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                hint: const Text("Filter Products"),
                value: state.seletedSortOption.isEmpty
                    ? null
                    : state.seletedSortOption,
                items: <String>[
                  'Name',
                  'Higher Price',
                  'Lower Price',
                  'Sale',
                  'Newest',
                  'Popularity'
                ]
                    .map((option) => DropdownMenuItem<String?>(
                          value: option,
                          child: Text(option),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  context
                      .read<AllProductBloc>()
                      .add(SortProducts(newValue!, state.productModel));
                }),

            const SizedBox(
              height: TSized.spacebetweenSections,
            ),
            GridLayout(
                itemBuilder: (_, index) {
                  return TProductCartVertical(
                    productModel: state.sortedProduct[index],
                  );
                },
                itemCount: state.sortedProduct.length)
          ],
        );
      },
    );
  }
}
