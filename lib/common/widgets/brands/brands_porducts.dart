import 'package:flutter/material.dart';
import 'package:store/common/widgets/products/sortable_products.dart';
import 'package:store/features/shop/model/feature_model/feature_model.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/size.dart';

class BrandsProducts extends StatelessWidget {
  const BrandsProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              FeatureBrandGridWidget(
                image: featureBrands[0].image,
                title: featureBrands[0].title,
                subTitle: featureBrands[0].subTitle.toString(),
                onTap:() => featureBrands[0].onTap!(context),
                showBorder: false,
              ),
              const SizedBox(height: TSized.spacebetweenItem,),
              const SortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
