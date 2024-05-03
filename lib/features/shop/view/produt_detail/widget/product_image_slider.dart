import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_bloc.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_event.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/curved/curved_widget.dart';
import 'package:store/common/widgets/favourite_icon/favourite_icon.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class ProductImageSlider extends StatefulWidget {
  final ProductModel? productModel;
  const ProductImageSlider({super.key, this.productModel});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  late List<String> images;
  late final Completer<void> _imageCompleter = Completer<void>();
  @override
  void initState() {
    super.initState();
    images = CategoriesRepository.getAllProductImage(widget.productModel!);
    context
        .read<UpdateDetailImageBloc>()
        .add(UpdateDetailImage(widget.productModel!.thumbnail));

    _imageCompleter.complete();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return FutureBuilder(
        future: _imageCompleter.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerEffect(
              height: 400,
              width: double.infinity,
            );
          } else {
            return BlocBuilder<UpdateDetailImageBloc, UpdateDetailImageState>(
              builder: (context, state) {
                return CurvedWidget(
                  child: Container(
                    color: dark ? TColors.darkGrey : TColors.light,
                    child: Stack(
                      children: [
                        // ! Main Large Image
                        GestureDetector(
                          onTap: () {
                            THelperFunction.showFullScreenDialog(
                                state.selectedProductImage!);
                          },
                          child: Hero(
                            tag: state.selectedProductImage!,
                            child: SizedBox(
                              height: 400,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    TSized.productImageRadius * 2),
                                child: CachedNetworkImage(
                                  imageUrl: state.selectedProductImage!,
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                          CircularProgressIndicator(
                                    value: progress.progress,
                                    color: TColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ! Image Slider
                        Positioned(
                            right: 0,
                            bottom: 30,
                            left: TSized.defaultSpace,
                            child: SizedBox(
                              height: 80,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  separatorBuilder: (_, __) => const SizedBox(
                                        width: TSized.spacebetweenItem,
                                      ),
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    final imageSeletected =
                                        state.selectedProductImage ==
                                            images[index];

                                    return TRoundedImage(
                                      onPressed: () {
                                        context
                                            .read<UpdateDetailImageBloc>()
                                            .add(UpdateDetailImage(
                                                images[index]));
                                      },
                                      width: 80,
                                      backgroundColor:
                                          dark ? TColors.dark : TColors.white,
                                      border: Border.all(
                                          color: imageSeletected
                                              ? TColors.primary
                                              : Colors.transparent),
                                      padding: const EdgeInsets.all(TSized.sm),
                                      imageUrl: images[index],
                                      isNetworkImage: true,
                                    );
                                  }),
                            )),
                        // ! Appbar Icons
                        CustomAppBar(
                          showBackArrow: true,
                          actions: [
                            FavouriteIcon(productId: widget.productModel!.id),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}
