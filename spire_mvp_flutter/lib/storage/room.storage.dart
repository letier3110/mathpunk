import '../classes/room/enemy_room.dart';
import '../classes/room/event_room.dart';
import '../classes/room/rest_room.dart';
import '../classes/room/room.dart';
import '../classes/room/trade_room.dart';
import '../classes/room/treasure_room.dart';

Room roomFromJson(dynamic json) {
  String jsonId = json['id'] as String;
  String jsonRuntime = json['_runtime'] as String;

  Room room;

  switch (jsonRuntime) {
    case 'EnemyRoom':
      room = EnemyRoom(roomId: jsonId);
      break;
    case 'TreasureRoom':
      room = TreasureRoom(roomId: jsonId);
      break;
    case 'TradeRoom':
      room = TradeRoom(roomId: jsonId);
      break;
    case 'RestRoom':
      room = RestRoom(roomId: jsonId);
      break;
    case 'EventRoom':
      room = EventRoom(roomId: jsonId);
      break;
    default:
      room = EnemyRoom(roomId: jsonId);
      break;
  }

  return room;
}

Map roomToJson(Room room) =>
    {...room.toJson(), '_runtime': room.runtimeType.toString()};
