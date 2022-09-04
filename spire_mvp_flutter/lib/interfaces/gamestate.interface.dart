import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/enemy/enemy.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/enums/game_type.enum.dart';
import 'package:mathpunk_cardgame/storage/character.storage.dart';
import 'package:mathpunk_cardgame/storage/room.storage.dart';

class GameStateInterface {
  GameTypeEnum? gameMode;
  bool inMap = false;
  bool inPause = false;
  PlayerCharacter? playerCharacter;
  List<Room> visitedRooms = [];
  final Player player = Player();
  List<List<Room>> gameMap = [];
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
      this.currentRoom,
      this.visitedRooms = const [],
      required this.playerName});

  factory GameStateInterface.fromJson(dynamic json) {
    GameTypeEnum parsedGameMode = decodeGameTypeFromJson(json['gameMode']);

    List<List<Room>> jsonRooms = (json['gameMap'] as List<List>)
        .map((List list) => list.map((e) => roomFromJson(e)).toList())
        .toList();

    List<Room> jsonVisitedRooms = (json['visitedRooms'] as List)
        .map((room) => roomFromJson(room))
        .toList();

    Room jsonCurrentRoom = roomFromJson(json['currentRoom']);

    PlayerCharacter character =
        playerCharacterFromJson(json['playerCharacter']);

    return GameStateInterface(
        gameMode: parsedGameMode,
        inMap: json['inMap'] as bool,
        inPause: json['inPause'] as bool,
        playerCharacter: character,
        gameMap: jsonRooms,
        visitedRooms: jsonVisitedRooms,
        currentRoom: jsonCurrentRoom,
        playerName: json['playerName'] as String);
  }

  Map toJson() => {
        'gameMode': gameMode.toString(),
        'inMap': inMap,
        'inPause': inPause,
        'playerCharacter': playerCharacter == null
            ? null
            : playerCharacterToJson(playerCharacter!),
        'gameMap': gameMap
            .map((list) => list.map((e) => roomToJson(e)).toList())
            .toList(),
        'visitedRooms': visitedRooms.map((e) => roomToJson(e)).toList(),
        'currentRoom': currentRoom == null ? null : roomToJson(currentRoom!),
        'playerName': playerName
      };
}
