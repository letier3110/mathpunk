import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';

final currentCardProvider =
    StateNotifierProvider<CurrentCardNotifier, PlayableCard?>((ref) {
  return CurrentCardNotifier(ref: ref);
});

class CurrentCardNotifier extends StateNotifier<PlayableCard?> {
  Ref ref;
  CurrentCardNotifier({PlayableCard? card, required this.ref}) : super(card);

  void removeCard() {
    state = null;
  }

  void setCard(PlayableCard card) {
    state = card;
  }

  void setCurrentEffect(CardState currentState, int? currentEffectId) {
    if (state == null) {
      return;
    }
    state!.currentState = currentState;
    if (currentEffectId != null) {
      state!.currentEffectId = currentEffectId;
    }
    state = state;
  }

  void updateCardEffect(CardEffect effect) {
    if (state == null) {
      return;
    }
    state!.effects = state!.effects.map((e) => e).toList();
    state = state;
  }

  void playCurrentEffect() {
    if (state == null) {
      return;
    }
    state!.effects[state!.currentEffectId].playEffect(state!, ref);
  }

  // void _updateState() {
  //   state = card;
  // }
}
