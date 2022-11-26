import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/room/room.dart';

final visitedRoomsProvider =
    StateNotifierProvider<VisitedRoomsNotifier, List<Room>>((ref) {
  return VisitedRoomsNotifier();
});

class VisitedRoomsNotifier extends StateNotifier<List<Room>> {
  VisitedRoomsNotifier({List<Room> rooms = const []}) : super(rooms);

  void addRoom(Room room) {
    state = [...state, room];
  }
}
