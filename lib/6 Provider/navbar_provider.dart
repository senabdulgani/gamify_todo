import 'package:flutter/material.dart';

class NavbarProvider with ChangeNotifier {
  int currentIndex = 1;

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
