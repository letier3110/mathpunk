import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 6;

class NormalityCard extends PlayableCard {
  NormalityCard(
      {cardName = 'Normality',
      cardDescription =
          'Unplayable.You cannot play more than 3 cards this turn.',
      cardMana = 1,
      cardDamage = 6})
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
              text: 'You cannot play more than 3 cards this turn.'),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {}
}
