import 'package:flutter/material.dart';
import '../enums/screens.enum.dart';

class NavigationController extends ChangeNotifier {
  ScreenEnum screen = ScreenEnum.mainMenu;

  void changeScreen(ScreenEnum newScreen) {
    screen = newScreen;
    notifyListeners();
  }
}
