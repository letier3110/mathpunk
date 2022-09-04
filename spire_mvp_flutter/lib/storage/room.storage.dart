import 'package:mathpunk_cardgame/classes/enemy/enemy.dart';
import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/classes/room/event_room/mind_bloom.event.dart';
import 'package:mathpunk_cardgame/storage/enemy.storage.dart';

import '../classes/room/enemy_room.dart';
import '../classes/room/event_room/event_room.dart';
import '../classes/room/rest_room.dart';
import '../classes/room/room.dart';
import '../classes/room/trade_room.dart';
import '../classes/room/treasure_room.dart';

Room roomFromJson(dynamic json) {
  String jsonId = json['id'] as String;
  List<Room> jsonNextRooms = ((json['nextRoom'] ?? []) as List).isEmpty
      ? []
      : (json['nextRoom'] as List).map((e) => roomFromJson(e)).toList();
  String jsonRuntime = json['_runtime'] as String;
  List<Enemy> jsonEnemies =
      (json['enemies'] as List).map((e) => enemyFromJson(e)).toList();
  List<Reward> jsonRewards =
      (json['rewards'] as List).map((e) => Reward.fromJson(e)).toList();

  Room room;

  switch (jsonRuntime) {
    case 'EnemyRoom':
      room = EnemyRoom(roomId: jsonId);
      room.attachEnemies(jsonEnemies);
      room.attachRewards(jsonRewards);
      break;
    case 'TreasureRoom':
      room = TreasureRoom(roomId: jsonId);
      room.attachEnemies(jsonEnemies);
      room.attachRewards(jsonRewards);
      break;
    case 'TradeRoom':
      room = TradeRoom.fromJson(json);
      break;
    case 'RestRoom':
      room = RestRoom(roomId: jsonId);
      room.attachEnemies(jsonEnemies);
      room.attachRewards(jsonRewards);
      break;
    case 'EventRoom':
      room = EventRoom(roomId: jsonId);
      room.attachEnemies(jsonEnemies);
      room.attachRewards(jsonRewards);
      break;
    case 'MindBloomEventRoom':
      room = MindBloomEventRoom(roomId: jsonId);
      room.attachEnemies(jsonEnemies);
      room.attachRewards(jsonRewards);
      break;
    default:
      room = EnemyRoom(roomId: jsonId);
      room.attachEnemies(jsonEnemies);
      room.attachRewards(jsonRewards);
      break;
  }

  room.nextRooms = jsonNextRooms;

  return room;
}

Map roomToJson(Room room) =>
    {...room.toJson(), '_runtime': room.runtimeType.toString()};
