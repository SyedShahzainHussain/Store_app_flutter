import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/authentication/bloc/on_board_controller_bloc.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/extension/language.dart';

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
              context
                  .read<OnBoardControllerBloc>()
                  .add(OnBoardControllerSkipPage());
            },
            child: Text(
              context.localizations!.skip,
            )));
  }
}
