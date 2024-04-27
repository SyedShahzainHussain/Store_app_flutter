
import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
class ResetTitleSubTitle extends StatelessWidget {
  const ResetTitleSubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Text(
          context.localizations!.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),
        Text(
          context.localizations!.changeYourPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}