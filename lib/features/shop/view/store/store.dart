import 'package:flutter/material.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/appBar/tapbar.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/product_cart/product_cart_widget.dart';
import 'package:store/common/widgets/text_field_container/text_field_container.dart';
import 'package:store/features/shop/model/feature_model/feature_model.dart';
import 'package:store/features/shop/view/allBrands/all_brands.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/store/widget/categories_tap.dart';
import 'package:store/features/shop/view/store/widget/feature_brand_widget.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor:
            THelperFunction.isDarkMode(context) ? TColors.black : TColors.white,
        appBar: CustomAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            ProductCartWidget(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunction.isDarkMode(context)
                  ? TColors.black
                  : TColors.white,
              expandedHeight: 440,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSized.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    // ! Search Bar
                    const TTextFieldContainer(
                      text: "Serarch in Store",
                      showBackGround: false,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
                    // ! Feature Brands
                    TSectionHeading(
                      title: "Featured Brands",
                      onPressed: () {
                        THelperFunction.navigatedToScreen(
                            context, const AllBrandsScreen());
                      },
                    ),
                    const SizedBox(
                      height: TSized.spacebetweenItem / 1.5,
                    ),
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
                    )
                  ],
                ),
              ),
              bottom: const TabBars(
                tabs: [
                  Tab(
                    text: "Sports",
                  ),
                  Tab(
                    text: "Furniture",
                  ),
                  Tab(
                    text: "Electronics",
                  ),
                  Tab(
                    text: "Clothes",
                  ),
                  Tab(
                    text: "Cosmetics",
                  )
                ],
              ),
            ),
          ],
          body: const TabBarView(children: [
            CategoryTab(),
            CategoryTab(),
            CategoryTab(),
            CategoryTab(),
            CategoryTab()
          ]),
        ),
      ),
    );
  }
}
