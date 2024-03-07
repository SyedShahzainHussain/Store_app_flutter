import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/texts.dart';

class SignUpPrivacy extends StatelessWidget {
  const SignUpPrivacy({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isCheck = ValueNotifier<bool>(false);
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: isCheck,
          builder: (context, value, child) => Checkbox(
            value: isCheck.value,
            onChanged: (value) {
              isCheck.value = !isCheck.value;
            },
          ),
        ),
        Flexible(
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: '${TTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${TTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: isDark ? TColors.white : TColors.primary)),
            TextSpan(
                text: '${TTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${TTexts.termOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: isDark ? TColors.white : TColors.primary)),
          ])),
        )
      ],
    );
  }
}
