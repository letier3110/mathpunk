import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/controllers/current_card.provider.dart';
import 'package:mathpunk_cardgame/utils/timer.util.dart';

final cardEffectProvider =
    StateNotifierProvider<CardEffectNotifier, CardEffectProviderInterface>(
        (ref) {
  return CardEffectNotifier(ref: ref);
});

class CardEffectProviderInterface {
  CardEffectProviderInterface();
  late StreamSubscription<int> cardEffectSubscription;
}

class CardEffectNotifier extends StateNotifier<CardEffectProviderInterface> {
  final Ref ref;

  CardEffectNotifier({required this.ref})
      : super(CardEffectProviderInterface());

  // void updateState() {
  //   state = CardEffectProviderInterface(card: state.card);
  // }

  void playTheCard(PlayableCard card) {
    var counterStream = timedCounter(card.effects);

    ref.read(currentCardProvider.notifier).setCard(card);
    state.cardEffectSubscription = counterStream.listen((int counter) {
      final currentEffect = card.effects[counter].state;
      ref
          .read(currentCardProvider.notifier)
          .setCurrentEffect(currentEffect, counter);
      if (card.effects[counter].isUserInteractionRequired) {
        state.cardEffectSubscription.pause();
        return;
      }
      card.effects[counter].playEffect(card, ref);
      _checkIfLastEffectPlayer(card, counter);
    });
    // updateState();
  }

  void playTheEffect(PlayableCard card, int effectId) {
    // card.effects[effectId].playEffect(card, ref);
    // TODO: do PlayableCard.playEffect with params in a card view and call playTheEffect of this
    _checkIfLastEffectPlayer(card, effectId);
    state.cardEffectSubscription.resume();
  }

  void _checkIfLastEffectPlayer(PlayableCard card, int effectId) {
    if (effectId == card.effects.length) {
      ref.read(currentCardProvider.notifier).removeCard();
    }
  }
}
