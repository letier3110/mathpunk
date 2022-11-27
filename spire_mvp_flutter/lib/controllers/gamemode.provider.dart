import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/enums/game_type.enum.dart';

final gamemodeProvider =
    StateNotifierProvider<InDeckNotifier, GameTypeEnum?>((ref) {
  return InDeckNotifier();
});

class InDeckNotifier extends StateNotifier<GameTypeEnum?> {
  InDeckNotifier({GameTypeEnum? gamemode}) : super(gamemode);

  void exitGameMode() {
    state = null;
  }

  void changeGameMode(GameTypeEnum newGameMode) {
    state = newGameMode;
  }
}
