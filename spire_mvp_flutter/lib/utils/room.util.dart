import 'dart:math';

import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/classes/room/event_room/event_room.dart';
import 'package:mathpunk_cardgame/classes/room/event_room/mind_bloom.event.dart';
import 'package:mathpunk_cardgame/classes/room/rest_room.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/classes/room/trade_room.dart';
import 'package:mathpunk_cardgame/classes/room/treasure_room.dart';
import 'package:mathpunk_cardgame/components/event_room/mind_bloom.view.dart';
import 'package:mathpunk_cardgame/screens/rooms/enemy_room.screen.dart';
import 'package:mathpunk_cardgame/screens/rooms/trader_room.screen.dart';

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
        Icons.shopping_cart_outlined,
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
    case MindBloomEventRoom:
      return const Icon(
        Icons.question_mark,
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
    case TradeRoom:
      return TraderRoomScreen(room: room as TradeRoom);
    case MindBloomEventRoom:
      return MindBloomView(room: room as MindBloomEventRoom);
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

bool getProbability(int probability) => Random().nextInt(100) <= probability;
