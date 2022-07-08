import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';

class GameStateInterface {
  GameTypeEnum? gameMode;
  bool inMap = false;
  bool inPause = false;
  PlayerCharacter? playerCharacter;
  final Player player = Player();
  List<Room> gameMap = [];
  Room? currentRoom;
  PlayableCard? selectingTarget;
  Enemy? selectedTarget;

  GameStateInterface(
      {required this.gameMode,
      required this.inMap,
      required this.inPause,
      required this.playerCharacter,
      required this.gameMap,
      required this.currentRoom});

  factory GameStateInterface.fromJson(dynamic json) {
    GameTypeEnum parsedGameMode = GameTypeEnum.standard;

    switch (json['gameMode']) {
      case 'standard':
        parsedGameMode = GameTypeEnum.standard;
        break;
      case 'daily':
        parsedGameMode = GameTypeEnum.daily;
        break;
      case 'custom':
      default:
        parsedGameMode = GameTypeEnum.custom;
        break;
    }
    return GameStateInterface(
        gameMode: parsedGameMode,
        inMap: json['inMap'] as bool,
        inPause: json['inPause'] as bool,
        playerCharacter:
            PlayerCharacter.fromJson(json), // TODO: implement serialize
        gameMap: json['gameMap'], // TODO: implement serialize
        currentRoom: json['currentRoom'] // TODO: implement serialize
        );
  }

  Map toJson() => {
        'gameMode': gameMode.toString(),
        'inMap': inMap,
        'inPause': inPause,
        'playerCharacter': playerCharacter,
        'gameMap': gameMap,
        'currentRoom': currentRoom,
      };
}
