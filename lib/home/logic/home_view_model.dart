import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  static const startIndex = 2;
  int currentIndex = startIndex;
  void updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
