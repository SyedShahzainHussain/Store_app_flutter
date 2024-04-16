import 'package:flutter/material.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(width: 180, height: 180),
                  SizedBox(
                    height: TSized.spacebetweenItem,
                  ),

                  // ! Text

                  ShimmerEffect(width: 160, height: 15),
                  SizedBox(
                    height: TSized.spacebetweenItem / 2,
                  ),

                  ShimmerEffect(width: 110, height: 15),
                ],
              ),
            ),
        itemCount: itemCount);
  }
}
