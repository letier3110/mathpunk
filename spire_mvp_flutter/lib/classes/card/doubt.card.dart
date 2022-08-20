import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
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
            cardTargetType: TargetEnum.unplayable,
            cardType: CardType.curse);

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
