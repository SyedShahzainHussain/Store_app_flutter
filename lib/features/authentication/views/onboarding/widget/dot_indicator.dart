import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/authentication/bloc/on_board_controller_bloc.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/utils/helper/helper_function.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Positioned(
        bottom: TDeviceUtils.getAppbarHeight() + 25,
        left: TSized.defaultSpace,
        child: SmoothPageIndicator(
          controller: context.read<OnBoardControllerBloc>().pageController,
          count: 3,
          effect: ExpandingDotsEffect(
            activeDotColor: isDark ? TColors.light : TColors.dark,
            dotHeight: 6,
          ),
        ));
  }
}
