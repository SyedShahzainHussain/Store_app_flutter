import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/variation/variation_bloc.dart';
import 'package:store/bloc/variation/variation_events.dart';
import 'package:store/bloc/variation/variation_state.dart';
import 'package:store/common/widgets/chip/t_chip.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/product_price/t_product_price_text.dart';
import 'package:store/common/widgets/texts/t_product_title.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';

class TProductAttributes extends StatelessWidget {
  final ProductModel productModel;
  const TProductAttributes({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return BlocBuilder<VariationBloc, VariationState>(
      builder: (context, state) {
        return Column(children: [
          // ! Selected Attribute Pricing & Description
          if (state.selectedVariation?.id.isNotEmpty ?? false)
            TRoundedContainer(
              padding: const EdgeInsets.all(TSized.md),
              backgroundColor: dark ? TColors.darkGrey : TColors.grey,
              child: Column(
                children: [
                  // ! Title , Price and Stock Status
                  Row(
                    children: [
                      TSectionHeading(
                        title: context.localizations!.variation,
                        showActionButton: false,
                      ),
                      const SizedBox(
                        width: TSized.spacebetweenItem,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TProductTitle(
                                title: "${context.localizations!.price} : ",
                                smallSize: true,
                              ),

                              // ! Actual Price
                              if (state.selectedVariation!.salePrice > 0)
                                Text(
                                  "\$${state.selectedVariation!.price}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              if (state.selectedVariation!.salePrice > 0)
                                const SizedBox(
                                  width: TSized.spacebetweenItem,
                                ),
                              TProductPriceText(
                                  price: (state.selectedVariation!.salePrice > 0
                                          ? state.selectedVariation!.salePrice
                                          : state.selectedVariation!.price)
                                      .toString())
                            ],
                          ),
                          Row(
                            children: [
                               TProductTitle(
                                title: "${context.localizations!.stock} : ",
                                smallSize: true,
                              ),
                              Text(
                                state.variationStockStatus,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ! Variation Description
                  TProductTitle(
                    title: state.selectedVariation?.description ?? "",
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),

          const SizedBox(
            height: TSized.spacebetweenItem,
          ),

          // ! Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: productModel.productAttributeModel!.map(
              (attribute) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TSectionHeading(
                      title: attribute.name ?? "",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem / 2,
                    ),
                    Wrap(
                      spacing: 8,
                      children: attribute.values!.map((value) {
                        final isSeltected =
                            state.selectedAttributes[attribute.name] == value;
                        final available = context
                            .read<VariationBloc>()
                            .getAttributesAvailabilityInVariation(
                                productModel.productVariationModel!,
                                attribute.name!)
                            .contains(value);
                        return TChoiceChip(
                          text: value,
                          selected: isSeltected,
                          onSelected: available
                              ? (selected) {
                                  if (selected && available) {
                                    context.read<VariationBloc>().add(Variation(
                                        productModel,
                                        attribute.name ?? "",
                                        value));
                                  }
                                }
                              : null,
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ).toList(),
          )
        ]);
      },
    );
  }
}
