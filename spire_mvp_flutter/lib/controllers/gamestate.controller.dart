import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';
import '../enums/screens.enum.dart';

class GamestateController extends ChangeNotifier {
  late GameTypeEnum? gameMode;

  void exitGameMode() {
    gameMode = null;
    notifyListeners();
  }

  void changeGameMode(GameTypeEnum newGameMode) {
    gameMode = newGameMode;
    notifyListeners();
  }
}
