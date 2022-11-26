import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';

final isLoreCardProvider =
    StateNotifierProvider<IsLoreCardNotifier, PlayableCard?>((ref) {
  return IsLoreCardNotifier();
});

class IsLoreCardNotifier extends StateNotifier<PlayableCard?> {
  IsLoreCardNotifier({PlayableCard? card}) : super(card);

  void openLoreCard(PlayableCard card) {
    state = card;
  }

  void closeLoreCard() {
    state = null;
  }
}
