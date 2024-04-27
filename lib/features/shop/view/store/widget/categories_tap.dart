import 'package:flutter/material.dart';

import 'package:store/common/widgets/brands/t_brand_showcase.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/products/t_cart_products_vertical.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';
import 'package:store/features/shop/view/allProducts/all_products.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';

import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/shimmer/boxex_shimmer.dart';
import 'package:store/utils/shimmer/list_tile_shimmer.dart';
import 'package:store/utils/shimmer/vertical_product_shimmer.dart';

class CategoryTab extends StatelessWidget {
  final String id;
  const CategoryTab({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Column(
              children: [
                // ! Brands
                FutureBuilder<List<BrandModel>>(
                    future: CategoriesRepository()
                        .getBrandBasedCategoryId(categoryId: id),
                    builder:
                        (context, AsyncSnapshot<List<BrandModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                      } else if (snapshot.hasData) {
                        final data = snapshot.data as List<BrandModel>;
                        return data.isEmpty
                            ?  Center(
                                child: Text(context.localizations!.noBrands),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TBrandShowCase(
                                    brandModel: data[index],
                                  );
                                },
                                itemCount: data.length,
                              );
                      } else {
                        return const SizedBox();
                      }
                    }),
                TSectionHeading(
                  title: context.localizations!.youMightLike,
                  buttontitle: context.localizations!.viewAll,
                  onPressed: () {
                    THelperFunction.navigatedToScreen(context, const AllProducts());
                  },
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),

                FutureBuilder(
                    future: CategoriesRepository()
                        .getProductSpecifidCategory(categoryId: id,limit: 4),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const VerticalProductShimmer();
                      } else {
                        return // ! Products
                            snapshot.data!.isEmpty
                                ?  Center(
                                    child: Text(context.localizations!.noProducts),
                                  )
                                : GridLayout(
                                    itemBuilder: (_, index) =>
                                        TProductCartVertical(
                                      productModel: snapshot.data![index],
                                    ),
                                    itemCount: snapshot.data!.length,
                                  );
                      }
                    }))
              ],
            ),
          ),
        ]);
  }
}
