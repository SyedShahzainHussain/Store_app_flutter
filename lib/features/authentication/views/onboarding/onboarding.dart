import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/features/authentication/controller/on_board_controller.dart';
import 'package:store/features/authentication/views/onboarding/widget/dot_indicator.dart';
import 'package:store/features/authentication/views/onboarding/widget/on_board_button.dart';
import 'package:store/features/authentication/views/onboarding/widget/on_boarding_skip.dart';
import 'package:store/features/authentication/views/onboarding/widget/onboarding_page.dart';

import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/texts.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ! Page
          Consumer<OnBoardController>(
            builder: (context, value, _) => PageView(
              controller: value.pageController,
              onPageChanged: value.onPageChange,
              children: const [
                OnBoardPage(
                  image: TImageString.onboard1,
                  title: TTexts.onBoardingTitle1,
                  subTitle: TTexts.onBoardingSubTitle1,
                ),
                OnBoardPage(
                  image: TImageString.onboard2,
                  title: TTexts.onBoardingTitle2,
                  subTitle: TTexts.onBoardingSubTitle2,
                ),
                OnBoardPage(
                  image: TImageString.onboard3,
                  title: TTexts.onBoardingTitle3,
                  subTitle: TTexts.onBoardingSubTitle3,
                ),
              ],
            ),
          )
          // ! Skip Button
          ,
          const OnBoardSkip(),
          // ! Dot Navigation
          const DotIndicator(),
          // ! Circular Button
          const OnBoardbutton()
        ],
      ),
    );
  }
}
