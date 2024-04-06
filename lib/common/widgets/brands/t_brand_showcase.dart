import 'package:flutter/material.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/features/shop/model/feature_model/feature_model.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';

class TBrandShowCase extends StatelessWidget {
  final List<Widget> image;
  const TBrandShowCase({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSized.md),
      margin: const EdgeInsets.only(bottom: TSized.spacebetweenItem),
      child: Column(
        children: [
          // ! Brand With Product Count
          FeatureBrandGridWidget(
            image: featureBrands[0].image,
            title: featureBrands[0].title,
            subTitle: featureBrands[0].subTitle.toString(),
            onTap:() => featureBrands[0].onTap!(context),
            showBorder: false,
          ),

          const SizedBox(
            height: TSized.spacebetweenItem,
          ),

          // ! Brand Top 3 Products Images
          Row(children: image)
        ],
      ),
    );
  }
}
