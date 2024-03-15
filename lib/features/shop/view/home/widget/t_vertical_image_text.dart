import 'package:flutter/material.dart';

import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class TVerticalImageText extends StatelessWidget {
  final String title;
  final String image;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  const TVerticalImageText({
    super.key,
    required this.title,
    required this.image,
    this.textColor = TColors.white,
    this.backgroundColor = TColors.white,
    this.onTap,
  });

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
                  color: (THelperFunction.isDarkMode(context)
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
              ),
            ),
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
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
