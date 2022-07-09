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
  String playerName;

  GameStateInterface(
      {required this.gameMode,
      required this.inMap,
      required this.inPause,
      required this.playerCharacter,
      required this.gameMap,
      required this.currentRoom,
      required this.playerName});

  factory GameStateInterface.fromJson(dynamic json) {
    GameTypeEnum parsedGameMode = decodeGameTypeFromJson(json['gameMode']);

    switch (json['gameMode']) {
      case GameTypeEnum.standard:
        parsedGameMode = GameTypeEnum.standard;
        break;
      case GameTypeEnum.daily:
        parsedGameMode = GameTypeEnum.daily;
        break;
      case GameTypeEnum.custom:
      default:
        parsedGameMode = GameTypeEnum.custom;
        break;
    }

    List<Room> jsonRooms =
        (json['gameMap'] as List).map((e) => Room.fromJson(e)).toList();

    Room jsonCurrentRoom = Room.fromJson(json['currentRoom']);

    return GameStateInterface(
        gameMode: parsedGameMode,
        inMap: json['inMap'] as bool,
        inPause: json['inPause'] as bool,
        playerCharacter: PlayerCharacter.fromJson(json['playerCharacter']),
        gameMap: jsonRooms,
        currentRoom: jsonCurrentRoom,
        playerName: json['playerName'] as String);
  }

  Map toJson() => {
        'gameMode': gameMode.toString(),
        'inMap': inMap,
        'inPause': inPause,
        'playerCharacter': playerCharacter?.toJson(),
        'gameMap': gameMap.map((e) => e.toJson()).toList(),
        'currentRoom': currentRoom?.toJson(),
        'playerName': playerName
      };
}
