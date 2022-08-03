import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 5;

class TwinStrikeCard extends PlayableCard {
  TwinStrikeCard(
      {cardName = 'Twin Strike',
      cardDescription = 'Deal 5(7) damage twice.',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    return HighlightDescriptionText(
        text:
            'Deal ${calculateDamage(damage: damage, mana: mana)} damage twice.');
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
    }
  }
}
