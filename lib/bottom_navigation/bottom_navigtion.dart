import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:store/features/personalizations/view/setting/setting.dart';
import 'package:store/features/shop/view/home/home.dart';
import 'package:store/features/shop/view/store/store.dart';
import 'package:store/features/shop/view/wishList/wiish_list.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helper/helper_function.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: state.currentIndex,
          onDestinationSelected: (index) =>
              BlocProvider.of<BottomNavigationBloc>(context)
                  .add(ChangeBottomIndexEvent(index)),
          backgroundColor: isDark ? TColors.black : TColors.white,
          indicatorColor: isDark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
            NavigationDestination(icon: Icon(Iconsax.heart), label: "WishList"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (
        context,
        state,
      ) =>
              screen[state.currentIndex]),
    );
  }

  List<Widget> screen = [
    const HomeScreen(),
    const StoreScreen(),
    const WishListScreen(),
    const SettingScreen()
  ];
}
