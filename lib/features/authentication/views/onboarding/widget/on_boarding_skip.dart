import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:provider/provider.dart';
import 'package:store/features/authentication/controller/onBoard_controller.dart';
class OnBoardSkip extends StatelessWidget {
  const OnBoardSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppbarHeight(),
        right: TSized.defaultSpace,
        child: TextButton(
            onPressed: () {
                 context.read<OnBoardController>().skipPage();
            },
            child: const Text(
              "Skip",
            )));
  }
}
