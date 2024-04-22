import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class HorizontalProductShimmer extends StatelessWidget {
  const HorizontalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                width: TSized.spacebetweenItem,
              ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerEffect(width: 100, height: 100),
                    ],
                  ),
                  SizedBox(
                    width: TSized.spacebetweenItem,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShimmerEffect(width: 160, height: 15),
                      SizedBox(
                        height: TSized.spacebetweenItem / 2,
                      ),
                      ShimmerEffect(width: 110, height: 15),
                    ],
                  ),
                ],
              ),
          itemCount: itemCount),
    );
  }
}
