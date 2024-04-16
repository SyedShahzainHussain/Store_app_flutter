import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_bloc.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/product_rating/product_rating.dart';
import 'package:store/features/shop/view/produt_detail/widget/product_image_slider.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_bottom_navigation_card.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_product_attributes.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_product_meta_data.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_rating_share.dart';
import 'package:store/utils/constants/size.dart';
import 'package:readmore/readmore.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel? productModel;
  const ProductDetails({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateDetailImageBloc(productModel!),
      child: Scaffold(
        bottomNavigationBar: const TBottomNavigationCard(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ! 1- Product Image Slider
              ProductImageSlider(
                productModel: productModel,
              ),
              // ! 2- Product Details
              Padding(
                padding: const EdgeInsets.only(
                  right: TSized.defaultSpace,
                  left: TSized.defaultSpace,
                  bottom: TSized.defaultSpace,
                ),
                child: Column(
                  children: [
                    // ! Rating & Share Button
                    const TRatingShare(),
                    // ! Price , Title ,Stocks & Brand
                    const TProductMetaData(),
                    // ! Attributes
                    const TProductAttributes(),
                    const SizedBox(
                      height: TSized.spacebetweenSections,
                    ),
                    // ! Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Checkout")),
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenSections,
                    ),
                    // ! Description
                    TSectionHeading(
                      title: "Description",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    const ReadMoreText(
                      "This is a Products description for blue Nike shoe less vest. There are more thing that can be added but im just practicing and nothing else.",
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: " Show more",
                      trimExpandedText: " Less",
                      moreStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),

                    // ! Reviews
                    const Divider(),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TSectionHeading(
                          title: "Reviews(120)",
                          showActionButton: false,
                          onPressed: () {},
                        ),
                        IconButton(
                            onPressed: () {
                              THelperFunction.navigatedToScreen(
                                  context, const ProductRating());
                            },
                            icon: const Icon(Iconsax.arrow_right_3))
                      ],
                    ),

                    const SizedBox(
                      height: TSized.spacebetweenSections,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
