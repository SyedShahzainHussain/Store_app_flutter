import 'package:flutter/material.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/features/shop/model/feature_model/feature_model.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/size.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Brand"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              // ! Heading
              TSectionHeading(
                title: "Brands",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              // ! Brands
              GridLayout(
                mainAxisExtent: 80,
                itemBuilder: (context, index) {
                  return FeatureBrandGridWidget(
                    image: featureBrands[index].image,
                    title: featureBrands[index].title,
                    subTitle: featureBrands[index].subTitle.toString(),
                    onTap: () => featureBrands[index].onTap!(context),
                    showBorder: true,
                  );
                },
                itemCount: featureBrands.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
