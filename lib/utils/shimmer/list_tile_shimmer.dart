import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            ShimmerEffect(
              width: 50,
              height: 50,
              radius: 50,
            ),
            SizedBox(
              width: TSized.spacebetweenItem,
            ),
            Column(
              children: [
                ShimmerEffect(width: 100, height: 15),
                SizedBox(
                  height: TSized.spacebetweenItem / 2,
                ),
                ShimmerEffect(width: 80, height: 12)
              ],
            )
          ],
        )
      ],
    );
  }
}
