import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';

import 'package:mathpunk_cardgame/classes/reward.dart';

final isOpenedChestProvider =
    StateNotifierProvider<IsOpenedChestNotifier, Reward?>((ref) {
  return IsOpenedChestNotifier();
});

class IsOpenedChestNotifier extends StateNotifier<Reward?> {
  IsOpenedChestNotifier({Reward? reward}) : super(reward);

  void selectChest(PlayerCharacter? playerCharacter, Reward reward) {
    if (playerCharacter == null) {
      playerCharacter!.resetRoundStatuses();
    }
    state = reward;
  }

  void stopSelectingChest() {
    state = null;
  }
}
