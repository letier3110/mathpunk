import 'package:flutter/material.dart';
import '../enums/screens.enum.dart';

class NavigationController extends ChangeNotifier {
  ScreenEnum screen = ScreenEnum.mainLoading;

  void changeScreen(ScreenEnum newScreen) {
    screen = newScreen;
    notifyListeners();
  }
}
