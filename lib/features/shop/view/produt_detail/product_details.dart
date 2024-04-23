import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/product_rating/product_rating.dart';
import 'package:store/features/shop/view/produt_detail/widget/product_image_slider.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_bottom_navigation_card.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_product_attributes.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_product_meta_data.dart';
import 'package:store/features/shop/view/produt_detail/widget/t_rating_share.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/size.dart';
import 'package:readmore/readmore.dart';
import 'package:store/utils/helper/helper_function.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel? productModel;
  const ProductDetails({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomNavigationCard(productModel: productModel!),
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
                  TProductMetaData(
                    productModel: productModel!,
                  ),
                  // ! Attributes
                  if (productModel!.productType ==
                      ProductType.variable.toString())
                    TProductAttributes(
                      productModel: productModel!,
                    ),
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
                  ReadMoreText(
                    productModel?.description ?? "",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: " Less",
                    textAlign: TextAlign.start,
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
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
    );
  }
}
