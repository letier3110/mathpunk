import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/event_room.dart';
import 'package:spire_mvp_flutter/classes/room/rest_room.dart';

import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/classes/room/treasure_room.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class RoomCard extends StatefulWidget {
  final Room room;

  const RoomCard({required this.room, Key? key}) : super(key: key);

  @override
  State<RoomCard> createState() => RoomCardView();
}

class RoomCardView extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    var isAvailable = gameState.getNextAvailableRooms().contains(widget.room) &&
        gameState.currentRoom?.getCanLeaveRoom() == true &&
        gameState.currentRoom?.id != widget.room.id;

    return GestureDetector(
        onTap: () => {gameState.enterRoom(widget.room)},
        child: Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.all(8),
          decoration: isAvailable
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 20.0,
                      spreadRadius: 0.0,
                    )
                  ],
                )
              : const BoxDecoration(),
          child: Card(
            color: isAvailable ? Colors.grey : Colors.amber,
            child: Center(
              child: Text(
                getRoomName(widget.room),
                style: Theme.of(context).textTheme.bodyLarge,
                // color: Colors.amber
              ),
            ),
          ),
        ));
  }
}

String getRoomName(Room room) {
  switch (room.runtimeType) {
    case EnemyRoom:
      return 'EnemyRoom';
    case TreasureRoom:
      return 'TreasureRoom';
    case TradeRoom:
      return 'TradeRoom';
    case RestRoom:
      return 'RestRoom';
    case EventRoom:
      return 'EVentRoom';
    default:
      return 'DefaultRoom';
  }
}
