import 'package:flutter/material.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_state.dart';
import 'package:store/features/shop/view/store/widget/categories_tap.dart';

class BottomTabBarView extends StatelessWidget {
  final FetchCategoriesState state;
  final TabController controller;
  const BottomTabBarView(
      {super.key, required this.state, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        children: state.featuresCategories
            .map(
              (category) => CategoryTab(id: category.id),
            )
            .toList());
  }
}
