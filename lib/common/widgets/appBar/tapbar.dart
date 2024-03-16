import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class TabBars extends StatelessWidget implements PreferredSizeWidget {
  const TabBars({super.key, required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          THelperFunction.isDarkMode(context) ? TColors.black : TColors.white,
      child: TabBar(
          unselectedLabelColor: TColors.darkGrey,
          indicatorColor: TColors.primary,
          isScrollable: true,
          labelColor: THelperFunction.isDarkMode(context)
              ? TColors.white
              : TColors.black,
          tabAlignment: TabAlignment.start,
          tabs: tabs),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(TSized.appBarHeight);
}
