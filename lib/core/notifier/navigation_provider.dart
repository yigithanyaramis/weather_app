import 'package:flutter/material.dart';

//Navigation'ımız için Provider
class NavigationProvider with ChangeNotifier {
  int _currentIndex;

  NavigationProvider({int selectedIndex = 0}) : _currentIndex = selectedIndex;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
