import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/event_room.dart';
import 'package:spire_mvp_flutter/classes/room/rest_room.dart';

import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/classes/room/treasure_room.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/room.util.dart';

class RoomCard extends StatefulWidget {
  final Room room;

  const RoomCard({required this.room, Key? key}) : super(key: key);

  @override
  State<RoomCard> createState() => RoomCardView();
}

class RoomCardView extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var isAvailable =
        (gameState.getNextAvailableRooms().contains(widget.room) &&
                gameState.currentRoom != null &&
                gameState.currentRoom?.getCanLeaveRoom() == true &&
                gameState.currentRoom?.id != widget.room.id) ||
            gameState.getNextAvailableRooms().contains(widget.room);

    var inRoom = gameState.currentRoom?.id == widget.room.id;

    void onTapHandler() {
      if (inRoom) {
        gameState.exitMap();
      } else {
        gameState.enterRoom(widget.room);
        gameState.playerCharacter!.startTurn();
      }
    }

    return GestureDetector(
        onTap: onTapHandler,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: isAvailable
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 20.0,
                      spreadRadius: 8.0,
                    )
                  ],
                )
              : const BoxDecoration(),
          child: Card(
            color: inRoom
                ? Colors.green
                : isAvailable
                    ? Colors.amber
                    : Colors.grey,
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
