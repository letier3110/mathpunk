import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';

class SelectCardCardEffect extends CardEffect {
  List<PlayableCard> card = [];

  SelectCardCardEffect({this.card = const []})
      : super(
            state: CardState.selectingTarget, isUserInteractionRequired: true);

  void selectCard(List<PlayableCard> card) {
    this.card = card;
  }

  @override
  void playEffect(PlayableCard card, Ref ref) {
    // TODO: implement playEffect
  }
}
