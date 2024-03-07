import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';

class OnBoardPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const OnBoardPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSized.defaultSpace),
      child: Column(
        children: [
          Image(
            height: TDeviceUtils.screenHeight(context) * 0.6,
            width: TDeviceUtils.screenWidth(context) * 0.8,
            image: AssetImage(image),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSized.spacebetweenItem,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
