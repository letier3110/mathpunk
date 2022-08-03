import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 6;

class AngerCard extends PlayableCard {
  AngerCard(
      {cardName = 'Anger',
      cardDescription = 'Deal 6 damage.',
      cardMana = 1,
      cardDamage = 6})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    return HighlightDescriptionText(
        text:
            'Deal ${calculateDamage(damage: damage, mana: mana)} damage.\nAdd a copy of this card to your discard pile.');
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
    }
    Player.getPlayerInstance().getCharacter().getDeck().addToDiscardPile(this);
  }
}
