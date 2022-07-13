import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/room.util.dart';

import '../utils/font.util.dart';

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

    var isNextRoom = gameState.getNextAvailableRooms().contains(widget.room);
    var isInRoom = gameState.currentRoom != null;

    var isAvailable = (!isInRoom && isNextRoom) ||
        (isInRoom &&
            gameState.currentRoom!.enemies.isEmpty &&
            gameState.currentRoom!.id != widget.room.id &&
            isNextRoom);

    var inCurrentRoom = gameState.currentRoom?.id == widget.room.id;

    void onTapHandler() {
      if (!isInRoom && isNextRoom) {
        gameState.enterRoom(widget.room);
        return;
      }
      if (isInRoom) {
        if (gameState.currentRoom!.enemies.isEmpty &&
            gameState.currentRoom!.id != widget.room.id &&
            isNextRoom) {
          gameState.enterRoom(widget.room);
          return;
        }
      }
      if (inCurrentRoom) {
        gameState.exitMap();
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
            color: inCurrentRoom
                ? Colors.green
                : isAvailable
                    ? Colors.amber
                    : Colors.grey,
            child: Center(
              child: Text(
                getRoomName(widget.room),
                style: TextStyle(fontSize: getFontSize(16)),
                // color: Colors.amber
              ),
            ),
          ),
        ));
  }
}
