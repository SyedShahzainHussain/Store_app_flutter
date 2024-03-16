import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:store/features/personalizations/view/setting/setting.dart';
import 'package:store/features/shop/view/home/home.dart';
import 'package:store/features/shop/view/store/store.dart';
import 'package:store/features/shop/view/wishList/wiishList.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/helper/helper_function.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationController(),
      child: Scaffold(
        bottomNavigationBar: Consumer<BottomNavigationController>(
          builder: (context, value, _) => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: value.currentIndex,
            onDestinationSelected: value.changeIndex,
            backgroundColor: isDark ? TColors.black : TColors.white,
            indicatorColor: isDark
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
              NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
              NavigationDestination(
                  icon: Icon(Iconsax.heart), label: "WishList"),
              NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
            ],
          ),
        ),
        body: Consumer<BottomNavigationController>(
            builder: (context, value, _) => value.screen[value.currentIndex]),
      ),
    );
  }
}

class BottomNavigationController with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Widget> screen = [
    const HomeScreen(),
    const StoreScreen(),
    const WishListScreen(),
    const SettingScreen()
  ];
}
