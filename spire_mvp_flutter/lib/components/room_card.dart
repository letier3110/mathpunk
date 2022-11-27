import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/controllers/current_room.provider.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_map.provider.dart';
import 'package:mathpunk_cardgame/controllers/visited_rooms.provider.dart';
import 'package:mathpunk_cardgame/utils/room.util.dart';

class RoomCard extends ConsumerStatefulWidget {
  final Room room;

  const RoomCard({required this.room, Key? key}) : super(key: key);

  @override
  ConsumerState<RoomCard> createState() => RoomCardView();
}

class RoomCardView extends ConsumerState<RoomCard> {
  @override
  Widget build(BuildContext context) {
    final currentRoom = ref.watch(currentRoomProvider);
    final visitedRooms = ref.watch(visitedRoomsProvider);
    final gameStateNotifier = ref.read(gamestateProvider.notifier);
    final inMapNotifier = ref.read(inMapProvider.notifier);

    var isNextRoom =
        gameStateNotifier.getNextAvailableRooms().contains(widget.room);
    Room? isVisited;

    try {
      isVisited = visitedRooms
          .firstWhere((element) => Room.isEqual(element, widget.room));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    var isInRoom = currentRoom != null;

    var isAvailable = (!isInRoom && isNextRoom) ||
        (isInRoom &&
            currentRoom.enemies.isEmpty &&
            currentRoom.id != widget.room.id &&
            isNextRoom);

    var inCurrentRoom = currentRoom?.id == widget.room.id;

    void onTapHandler() {
      if (!isInRoom && isNextRoom) {
        gameStateNotifier.enterRoom(widget.room);
        return;
      }
      if (isInRoom) {
        if (currentRoom.enemies.isEmpty &&
            currentRoom.id != widget.room.id &&
            isNextRoom) {
          gameStateNotifier.enterRoom(widget.room);
          inMapNotifier.exitMap();
          return;
        }
      }
      if (inCurrentRoom) {
        inMapNotifier.exitMap();
      }
    }

    return GestureDetector(
        onTap: onTapHandler,
        child: Container(
          margin: const EdgeInsets.all(4),
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
                : isVisited != null
                    ? Colors.lightGreen
                    : isAvailable
                        ? Colors.amber
                        : Colors.grey,
            child: Center(child: getRoomIcon(widget.room)),
          ),
        ));
  }
}
