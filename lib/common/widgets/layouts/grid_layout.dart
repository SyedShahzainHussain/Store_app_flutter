import 'package:flutter/material.dart';
import 'package:store/utils/constants/size.dart';

class GridLayout extends StatelessWidget {
  final int itemCount;
  final double? mainAxisExtent;
  final int crossAxisCount;
  final Axis scrollDirection;
  final Widget? Function(BuildContext, int) itemBuilder;

  const GridLayout(
      {super.key,
      required this.itemBuilder,
      required this.itemCount,
      this.mainAxisExtent = 268,
      this.crossAxisCount = 2,
      this.scrollDirection = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      scrollDirection: scrollDirection,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: TSized.gridViewSpacing,
        crossAxisSpacing: TSized.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
