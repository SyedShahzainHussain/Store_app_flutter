import 'package:flutter/material.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class BrandShimmer extends StatelessWidget {
  final int itemCount;
  const BrandShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
        itemBuilder: (context, index) => const ShimmerEffect(width: 300, height: 80),
        itemCount: itemCount);
  }
}
