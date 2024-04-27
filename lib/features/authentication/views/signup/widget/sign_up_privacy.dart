import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/extension/language.dart';

class SignUpPrivacy extends StatelessWidget {
  const SignUpPrivacy({
    super.key,
    required this.isDark,
    required this.isCheck
  });

  final bool isDark;
  final ValueNotifier<bool> isCheck;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: isCheck,
          builder: (context, value, child) => Checkbox(
            value: isCheck.value,
            onChanged: (value) {
              isCheck.value = !isCheck.value;
              if (!isCheck.value) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Agreement Required"),
                      content:
                          const Text("Please agree to the terms to proceed."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
        Flexible(
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: '${context.localizations!.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${context.localizations!.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: isDark ? TColors.white : TColors.primary)),
            TextSpan(
                text: '${context.localizations!.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${context.localizations!.termOfUse} ',
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
