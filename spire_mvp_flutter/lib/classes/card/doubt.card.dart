import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

class DoubtCard extends PlayableCard {
  int damage = 6;

  DoubtCard(
      {cardName = 'Doubt',
      cardDescription = 'Unplayable.At the end of your turn, gain 1 Weak.',
      cardMana = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.curse);

  @override
  bool isCardPlayable() => false;

  @override
  StatelessWidget getCardDescription(BuildContext context) {
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
