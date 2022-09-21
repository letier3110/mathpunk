import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

int damage = 6;

class DoubtCard extends PlayableCard {
  DoubtCard(
      {cardName = 'Doubt',
      cardDescription = 'Unplayable.At the end of your turn, gain 1 Weak.',
      cardMana = 0,
      cardDamage = 0})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.curse);

  @override
  bool isCardPlayable() => false;

  @override
  StatelessWidget getCardDescription() {
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Unplayable.'),
          HighlightDescriptionText(
              text: 'At the end of your turn, gain 1 Weak.'),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {}
}
