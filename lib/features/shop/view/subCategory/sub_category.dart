import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_sub_category/fetch_sub_category_bloc.dart';
import 'package:store/bloc/fetch_sub_category/fetch_sub_category_event.dart';
import 'package:store/bloc/fetch_sub_category/fetch_sub_category_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/common/widgets/products/t_cart_procucts_horizontal.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';
import 'package:store/features/shop/view/allProducts/all_products.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/shimmer/horizontal_product_shimmer.dart';
import 'package:store/utils/shimmer/vertical_product_shimmer.dart';

class SubCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  const SubCategory({super.key, required this.categoryModel});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  void initState() {
    super.initState();
    context
        .read<FetchSubCategoryBloc>()
        .add(FetchSubCategory(widget.categoryModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(widget.categoryModel.name.capitalize()),
          showBackArrow: true),
      body: BlocBuilder<FetchSubCategoryBloc, FetchSubCategoryState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Padding(
                padding: EdgeInsets.all(TSized.defaultSpace),
                child: VerticalProductShimmer(),
              );
            case Status.success:
              if (state.subCategoryList.isEmpty) {
                return const Center(
                  child: Text("No Product Found"),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(TSized.defaultSpace),
                  child: Column(
                    children: [
                      // ! Banner
                      TRoundedImage(
                        imageUrl: TImageString.promoBanner1,
                        height: TDeviceUtils.screenHeight(context) / 7,
                        fit: BoxFit.fitWidth,
                        width: TDeviceUtils.screenWidth(context),
                      ),
                      const SizedBox(
                        height: TSized.spacebetweenSections,
                      ),

                      // ! Sub Category
                      ListView.builder(
                        itemCount: state.subCategoryList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final subCategory = state.subCategoryList[index];
                          return FutureBuilder(
                              future: CategoriesRepository()
                                  .getProductSpecifidCategory(
                                categoryId: subCategory.id,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const HorizontalProductShimmer();
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  final data = snapshot.data;
                                  if (data!.isEmpty) {
                                    return const Center(
                                      child: Text(
                                          "No Sub Category Products Found"),
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        // ! Heading
                                        TSectionHeading(
                                          title: subCategory.name,
                                          onPressed: () {
                                            THelperFunction.navigatedToScreen(
                                                context, const AllProducts());
                                          },
                                        ),
                                        const SizedBox(
                                          height:
                                              TSized.spacebetweenSections / 2,
                                        ),

                                        SizedBox(
                                          height: 120,
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              width: TSized.spacebetweenItem,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) =>
                                                TProductCartHorizontal(
                                              productModel: data[index],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: TSized.spacebetweenSections,
                                        ),
                                      ],
                                    );
                                  }
                                }
                              });
                        },
                      )
                    ],
                  ),
                ),
              );
            case Status.failure:
              return Center(
                child: Text(state.message),
              );
          }
        },
      ),
    );
  }
}
