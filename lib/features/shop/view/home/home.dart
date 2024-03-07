import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/text_field_container/text_field_container.dart';
import 'package:store/features/shop/view/home/widget/home_app_bar.dart';
import 'package:store/features/shop/view/home/widget/t_primary_header_container.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/helper/helper_function.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              // ! Home App Bar
              const HomeAppBar(),

              SizedBox(
                height: TDeviceUtils.screenWidth(context) * 0.03,
              ),
              // ! Search Text Field
              const TTextFieldContainer(
                text: "Search In Store",
              ),
              SizedBox(
                height: TDeviceUtils.screenWidth(context) * 0.03,
              ),
              // ! Categories listview horizontal
              TSectionHeading(
                title: "Popular Categories",
                showActionButton: false,
                textColor: isDark ? TColors.black : TColors.white,
              ),
              SizedBox(
                height: TDeviceUtils.screenWidth(context) * 0.05,
              ),
              // ! Categories
              Padding(
                padding: const EdgeInsets.only(left: TSized.defaultSpace),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contect, index) => const TVerticalImageText(
                      image: TImageString.bowlingImage,
                      title: "Bowling",
                    ),
                    itemCount: 6,
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}

class TVerticalImageText extends StatelessWidget {
  final String title;
  final String image;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  const TVerticalImageText(
      {super.key,
      required this.title,
      required this.image,
      this.textColor = TColors.white,
      this.backgroundColor = TColors.white,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSized.spacebetweenItem),
        child: Column(
          children: [
            Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(TSized.sm),
                decoration: BoxDecoration(
                    color:
                        (THelperFunction.isDarkMode(context)
                            ? TColors.black
                            : TColors.white),
                    borderRadius: BorderRadius.circular(100)),
                child: Image(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                  color: THelperFunction.isDarkMode(context)
                            ? TColors.light
                            : TColors.dark,
                )),
            // ! Text
            const SizedBox(
              height: TSized.spacebetweenItem / 2,
            ),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: textColor,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
