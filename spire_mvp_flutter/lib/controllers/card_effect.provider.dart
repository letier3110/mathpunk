import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/utils/timer.util.dart';

final cardEffectProvider =
    StateNotifierProvider<CardEffectNotifier, CardEffectProviderInterface>(
        (ref) {
  return CardEffectNotifier(ref: ref);
});

class CardEffectProviderInterface {
  CardEffectProviderInterface({this.card});
  PlayableCard? card;
  late StreamSubscription<int> cardEffectSubscription;
}

class CardEffectNotifier extends StateNotifier<CardEffectProviderInterface> {
  final Ref ref;

  CardEffectNotifier({PlayableCard? card, required this.ref})
      : super(CardEffectProviderInterface(card: card));

  void updateState() {
    state = CardEffectProviderInterface(card: state.card);
  }

  void playTheCard(PlayableCard card) {
    var counterStream = timedCounter(card.effects);

    state.cardEffectSubscription = counterStream.listen((int counter) {
      if (card.effects[counter].isUserInteractionRequired) {
        state.cardEffectSubscription.pause();
        return;
      }
      card.effects[counter].playEffect(card, ref);
    });
    updateState();
  }

  Map toJson() => {'card': state.card?.toJson()};
}
