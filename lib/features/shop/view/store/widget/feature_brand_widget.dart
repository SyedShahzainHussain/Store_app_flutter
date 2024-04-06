import 'package:flutter/material.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/common/widgets/image/t_circular_image.dart';
import 'package:store/common/widgets/texts/t_brand_verification.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/enum.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class FeatureBrandGridWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final Function()? onTap;
  final bool showBorder;
  const FeatureBrandGridWidget({
    super.key,
    required this.image,
    required this.subTitle,
    required this.title,
    required this.onTap,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSized.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // ! Icon
            Flexible(
              child: TCircularImage(
                image: image,
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunction.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
              ),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem / 2,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleAndVerification(
                    title: title,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    subTitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
