import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/extension.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({
    super.key,
    required this.isDark,
    required this.title,
  });

  final bool isDark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            thickness: 0.9,
            color: isDark ? TColors.darkGrey : TColors.grey,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          title.capitalize(),
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            thickness: 0.9,
            color: isDark ? TColors.darkGrey : TColors.grey,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
