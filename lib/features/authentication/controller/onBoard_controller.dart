import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/utils/helper/helper_function.dart';

class OnBoardController with ChangeNotifier {
  PageController pageController = PageController();
  int currentPage = 0;

  // ! page changed
  onPageChange(int index) {
    currentPage = index;
    notifyListeners();
  }

  // ! skip page
  skipPage() {
    currentPage = 2;
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  // ! next page
  nextPage(BuildContext context) async {
    if (currentPage == 2) {
      final storage = GetStorage();
      await storage.write("IsFirstTime", false);
      THelperFunction.navigatedToScreen(context, const Login());
    } else {
      pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
    notifyListeners();
  }
}
