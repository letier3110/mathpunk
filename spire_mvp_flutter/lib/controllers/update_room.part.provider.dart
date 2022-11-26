import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/controllers/current_room.provider.dart';
import 'package:mathpunk_cardgame/controllers/visited_rooms.provider.dart';

final updateRoomPartProvider =
    StateNotifierProvider<UpdateRoomPartProvider, void>((ref) {
  return UpdateRoomPartProvider(ref: ref);
});

class UpdateRoomPartProvider extends StateNotifier<void> {
  Ref ref;
  UpdateRoomPartProvider({required this.ref}) : super([]);

  void updateRoom(Room room) {
    ref.read(currentRoomProvider.notifier).replaceRoom(room);
    ref.read(visitedRoomsProvider.notifier).addRoom(room);
  }
}
