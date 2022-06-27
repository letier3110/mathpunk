import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/enigma_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/mage_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/rogue_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/warrior_character.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';

class GamestateController extends ChangeNotifier {
  GameTypeEnum? gameMode;
  PlayerCharacter? playerCharacter;
  final List<PlayerCharacter> playableCharacters = [
    Warrior(),
    Mage(),
    Rogue(),
    Enigma()
  ];

  void exitGameMode() {
    gameMode = null;
    notifyListeners();
  }

  void changeGameMode(GameTypeEnum newGameMode) {
    gameMode = newGameMode;
    notifyListeners();
  }

  void stopPlaying() {
    playerCharacter = null;
    notifyListeners();
  }

  void selectPlayerCharacter(PlayerCharacter character) {
    playerCharacter = character;
    notifyListeners();
  }
}
