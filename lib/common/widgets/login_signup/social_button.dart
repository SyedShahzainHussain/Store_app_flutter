import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';

class SoicalButton extends StatelessWidget {
  const SoicalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Image(
                  height: TSized.iconMd,
                  width: TSized.iconMd,
                  image: AssetImage(TImageString.google)),
            )),
            const SizedBox(width: TSized.spacebetweenItem,),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Image(
                  height: TSized.iconMd,
                  width: TSized.iconMd,
                  image: AssetImage(TImageString.facebook)),
            ))
      ],
    );
  }
}
