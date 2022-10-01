import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/deck.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

int block = 9;
int maxSelectableCards = 1;

class TrueGiftUpgradeCard extends PlayableCard {
  TrueGiftUpgradeCard({
    cardName = 'True Grit+',
    cardDescription =
        'Gain 7(9) Block. Exhaust a selected card from your hand.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardSteps: 1,
            cardMaxSteps: 3,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill);

  @override
  StatelessWidget getCardName() {
    return Text(
      name,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription() {
    int localBlock = block;

    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Gain $localBlock Block.'),
          HighlightDescriptionText(
              text: 'Exhaust a selected card from your hand.'),
        ],
      ),
    );
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
      int localBlock = block;
      character.addBlock(localBlock);
      step++;
      targetType = TargetEnum.cardTarget;
    } else {
      if (selectedCards.isNotEmpty) {
        List<PlayableCard> hand = character.getDeck().getHand();
        // List<PlayableCard> discardPile = deck.getHand();
        // List<PlayableCard> drawPile = deck.getDrawPile();

        selectedCards[0].exhausted = true;
        selectedCards[0]
            .disposeToDiscard(hand, character.getDeck().exhaustPile);
        setSelectedCards([]);
      }
      targetType = TargetEnum.allTargets;
      step++;
    }
  }
}
