import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../../enums/target.enum.dart';
import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

int draw = 1;
int maxSelectableCards = 1;

class WarCryCard extends PlayableCard {
  WarCryCard(
      {cardName = 'Warcry',
      cardDescription =
          'Draw 1(2) card(s). Place a card from your hand on top of your draw pile. Exhaust.',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardSteps: 1,
            cardMaxSteps: 3,
            cardExhaused: true,
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill);

  @override
  StatelessWidget getCardDescription() {
    int localDraw = draw;

    return HighlightDescriptionText(
        text:
            'Draw $localDraw card.\nPlace a card from your hand on top of your draw pile.\nExhaust.');
  }

  @override
  List<PlayableCard> getSelectableCards() {
    return Player.getPlayerInstance().getCharacter().getDeck().getHand();
  }

  @override
  int getMaxSelectableCards() {
    int localMaxSelectableCards = maxSelectableCards;
    return localMaxSelectableCards;
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    if (step == 1) {
      int localDraw = draw;
      character.deck.draw(localDraw);
      step++;
      targetType = TargetEnum.cardTarget;
    } else {
      if (selectedCards.isNotEmpty) {
        List<PlayableCard> hand = character.deck.getHand();
        List<PlayableCard> drawPile = character.deck.getDrawPile();

        drawPile.insert(0, selectedCards[0]);
        hand.remove(selectedCards[0]);
        setSelectedCards([]);
      }
      targetType = TargetEnum.allTargets;
      step++;
    }
  }
}
