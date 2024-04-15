import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  final int itemCount;
  const CategoryShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(
                width: 55,
                height: 55,
                radius: 55,
              ),
              SizedBox(
                height: TSized.spacebetweenItem / 2,
              ),
              ShimmerEffect(width: 55, height: 8)
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: TSized.spacebetweenItem,
        ),
        itemCount: itemCount,
      ),
    );
  }
}
