import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';

final inDeckProvider =
    StateNotifierProvider<InDeckNotifier, List<PlayableCard>>((ref) {
  return InDeckNotifier();
});

class InDeckNotifier extends StateNotifier<List<PlayableCard>> {
  InDeckNotifier({List<PlayableCard> inDeck = const []}) : super(inDeck);

  void enterDeck({List<PlayableCard> cards = const []}) {
    if (cards.isEmpty) {
      return;
    }
    state = cards;
  }

  void exitDeck() {
    state = [];
  }
}
