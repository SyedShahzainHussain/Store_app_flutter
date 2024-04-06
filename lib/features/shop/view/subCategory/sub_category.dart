import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/image/t_rounded_image.dart';
import 'package:store/common/widgets/products/t_cart_procucts_horizontal.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Text("Sports"), showBackArrow: true),
      body: SingleChildScrollView(
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
              Column(children: [
                // ! Heading
                TSectionHeading(
                  title: "Sport Shirts",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: TSized.spacebetweenSections / 2,
                ),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            width: TSized.spacebetweenItem,
                          ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) =>
                          const TProductCartHorizontal()),
                ),
                const SizedBox(
                  height: TSized.spacebetweenSections,
                ),
                // ! Heading
                TSectionHeading(
                  title: "Sport Shirts",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: TSized.spacebetweenSections / 2,
                ),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            width: TSized.spacebetweenItem,
                          ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) =>
                          const TProductCartHorizontal()),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
