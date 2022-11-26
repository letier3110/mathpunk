import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';

final selectingCardRewardProvider =
    StateNotifierProvider<SelectingCardRewardNotifier, List<PlayableCard>>(
        (ref) {
  return SelectingCardRewardNotifier();
});

class SelectingCardRewardNotifier extends StateNotifier<List<PlayableCard>> {
  SelectingCardRewardNotifier(
      {List<PlayableCard> selectingCardReward = const []})
      : super(selectingCardReward);

  void addRewards(List<PlayableCard> cards) {
    state = cards;
  }

  void removeRewards() {
    state = [];
  }
}
