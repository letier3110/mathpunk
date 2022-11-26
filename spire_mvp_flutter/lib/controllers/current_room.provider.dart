import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';

import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/classes/room/trade_room.dart';
import 'package:mathpunk_cardgame/controllers/enter_enemy_room.part.provider.dart';

final currentRoomProvider =
    StateNotifierProvider<CurrentRoomNotifier, Room?>((ref) {
  return CurrentRoomNotifier(ref: ref);
});

class CurrentRoomNotifier extends StateNotifier<Room?> {
  Ref ref;
  CurrentRoomNotifier({required this.ref, Room? room}) : super(room);

  void visitTrader() {
    if (state == null) return;
    (state as TradeRoom).visitedTrader = true;
  }

  void disposeRoom() {
    state = null;
  }

  void replaceRoom(Room room) {
    state = room;
  }

  void changeCurrentRoom(Room room) {
    if (state == null) return;
    state = room;
    if (state.runtimeType == EnemyRoom) {
      ref.read(eneterEnemyRoomPartProvider.notifier).enemyRoomEnter();
    }
  }
}
