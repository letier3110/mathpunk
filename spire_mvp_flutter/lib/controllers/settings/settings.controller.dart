import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  int screenWidth = 1280;
  int screenHeight = 720;

  void changeScreenSize({int screenWidth = 1280, int screenHeight = 720}) {
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    notifyListeners();
  }
}
