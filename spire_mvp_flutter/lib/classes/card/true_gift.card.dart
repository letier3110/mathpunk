import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

int block = 7;

class TrueGiftCard extends PlayableCard {
  TrueGiftCard({
    cardName = 'True Grit',
    cardDescription =
        'Gain 7(9) Block. Exhaust a random(not random) card from your hand.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill);

  @override
  StatelessWidget getCardDescription() {
    int localBlock = block;

    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Gain $localBlock Block.'),
          HighlightDescriptionText(
              text: 'Exhaust a random card from your hand.'),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localBlock = block;
    character.addBlock(localBlock);
    List<PlayableCard> hand = character.getDeck().getHand();
    int cardIndex = Random().nextInt(hand.length - 1);
    hand[cardIndex].exhausted = true;
    hand[cardIndex].disposeToDiscard(hand, character.getDeck().exhaustPile);
  }
}
