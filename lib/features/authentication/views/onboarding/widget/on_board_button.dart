import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/features/authentication/controller/on_board_controller.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/utils/helper/helper_function.dart';

class OnBoardbutton extends StatelessWidget {
  const OnBoardbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Positioned(
      bottom: TDeviceUtils.getBottombarHeight(),
      right: TSized.defaultSpace,
      child: ElevatedButton(
        onPressed: () {
          context.read<OnBoardController>().nextPage(context);
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: isDark ? TColors.primary : Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
