import 'package:flutter/cupertino.dart';

import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/event_room.dart';
import 'package:spire_mvp_flutter/classes/room/rest_room.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/classes/room/treasure_room.dart';
import 'package:spire_mvp_flutter/screens/enemy_room.screen.dart';

String getRoomName(Room room) {
  var id = room.id;
  switch (room.runtimeType) {
    case EnemyRoom:
      return 'EnemyRoom $id';
    case TreasureRoom:
      return 'TreasureRoom';
    case TradeRoom:
      return 'TradeRoom';
    case RestRoom:
      return 'RestRoom';
    case EventRoom:
      return 'EventRoom';
    default:
      return 'DefaultRoom';
  }
}

Widget getRoomComponent(Room room) {
  switch (room.runtimeType) {
    case EnemyRoom:
      return EnemyRoomScreen(room: room as EnemyRoom);
    default:
      return EnemyRoomScreen(room: room as EnemyRoom);
    // TODO: implement other types of rooms
    // case TreasureRoom:
    //   return 'TreasureRoom';
    // case TradeRoom:
    //   return 'TradeRoom';
    // case RestRoom:
    //   return 'RestRoom';
    // case EventRoom:
    //   return 'EventRoom';
    // default:
    //   return 'DefaultRoom';
  }
}
