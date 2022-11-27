import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/storage/room.storage.dart';

class GameStateInterface {
  final Player player = Player();
  List<List<Room>> gameMap = [];
  String playerName;

  GameStateInterface({required this.gameMap, required this.playerName});

  factory GameStateInterface.fromJson(dynamic json) {
    List<List<Room>> jsonRooms = (json['gameMap'] as List<List>)
        .map((List list) => list.map((e) => roomFromJson(e)).toList())
        .toList();

    return GameStateInterface(
        gameMap: jsonRooms, playerName: json['playerName'] as String);
  }

  Map toJson() => {
        'gameMap': gameMap
            .map((list) => list.map((e) => roomToJson(e)).toList())
            .toList(),
        'playerName': playerName
      };
}
