import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/authentication/bloc/on_board_controller_bloc.dart';
import 'package:store/features/authentication/views/onboarding/widget/dot_indicator.dart';
import 'package:store/features/authentication/views/onboarding/widget/on_board_button.dart';
import 'package:store/features/authentication/views/onboarding/widget/on_boarding_skip.dart';
import 'package:store/features/authentication/views/onboarding/widget/onboarding_page.dart';

import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/extension/language.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ! Page
          BlocBuilder<OnBoardControllerBloc, OnBoardControllerState>(
            builder: (context, state) => PageView(
              controller: context.read<OnBoardControllerBloc>().pageController,
              onPageChanged: (index) => context
                  .read<OnBoardControllerBloc>()
                  .add(OnBoardControllerPageChange(index)),
              children: [
                OnBoardPage(
                  image: TImageString.onboard1,
                  title: context.localizations!.onBoardingTitle1,
                  subTitle: context.localizations!.onBoardingSubTitle1,
                ),
                OnBoardPage(
                  image: TImageString.onboard2,
                  title: context.localizations!.onBoardingTitle2,
                  subTitle: context.localizations!.onBoardingSubTitle2,
                ),
                OnBoardPage(
                  image: TImageString.onboard3,
                  title: context.localizations!.onBoardingTitle3,
                  subTitle: context.localizations!.onBoardingSubTitle3,
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
