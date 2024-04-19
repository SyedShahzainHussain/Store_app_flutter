import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/shimmer/shimmer.dart';

class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(children: [
        Expanded(child: ShimmerEffect(width: 150, height: 110)),
        SizedBox(width: TSized.spacebetweenItem,),
        Expanded(child: ShimmerEffect(width: 150, height: 110)),
        SizedBox(width: TSized.spacebetweenItem,),
        Expanded(child: ShimmerEffect(width: 150, height: 110)),
      ],)
    ],);
  }
}