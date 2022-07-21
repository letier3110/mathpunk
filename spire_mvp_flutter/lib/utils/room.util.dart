import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

Widget getRoomIcon(Room room) {
  var id = room.id;
  switch (room.runtimeType) {
    case EnemyRoom:
      if (room.id.contains('boss')) {
        return const Icon(
          Icons.android,
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        );
      }
      return const Icon(
        Icons.smart_toy,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case TreasureRoom:
      return const Icon(
        Icons.smart_toy,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case TradeRoom:
      return const Icon(
        Icons.smart_toy,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case RestRoom:
      return const Icon(
        Icons.smart_toy,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    case EventRoom:
      return const Icon(
        Icons.smart_toy,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    default:
      return const Icon(
        Icons.smart_toy,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
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
