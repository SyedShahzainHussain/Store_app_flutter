import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
