
import 'package:flutter/material.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/constants/size.dart';
class ResetTitleSubTitle extends StatelessWidget {
  const ResetTitleSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),
        Text(
          TTexts.changeYourPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}