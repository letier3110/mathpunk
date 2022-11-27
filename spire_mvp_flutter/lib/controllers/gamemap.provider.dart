import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/game_map.dart';

import 'package:mathpunk_cardgame/classes/room/room.dart';

final gamemapProvider =
    StateNotifierProvider<GameMapNotifier, List<List<Room>>>((ref) {
  return GameMapNotifier();
});

class GameMapNotifier extends StateNotifier<List<List<Room>>> {
  GameMapNotifier({List<List<Room>> inDeck = const []}) : super(inDeck);

  void clearMap() {
    state = [];
  }

  void prepareGameMap() {
    state = generateMap();
  }
}
