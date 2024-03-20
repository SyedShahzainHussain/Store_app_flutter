
import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/device/devices_utility.dart';

class TRatingIndicator extends StatelessWidget {
  const TRatingIndicator({
    super.key,
    required this.value,
    required this.text,
  });
  final double value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.screenWidth(context) * 0.5,
            child: LinearProgressIndicator(
              minHeight: 10,
              value: value,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(TColors.primary),
            ),
          ),
        )
      ],
    );
  }
}
