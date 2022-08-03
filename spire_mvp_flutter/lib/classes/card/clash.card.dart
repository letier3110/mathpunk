import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 14;

class ClashCard extends PlayableCard {
  ClashCard({
    cardName = 'Clash',
    cardDescription =
        'Can only be played if every card in your hand is an Attack. Deal 14(18) damage.',
    cardMana = 0,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    return HighlightDescriptionText(
        text:
            'Can only be played if every card in your hand is an Attack.\nDeal ${calculateDamage(damage: damage, mana: mana)} damage.');
  }

  @override
  bool isCardPlayable() {
    List<PlayableCard> hand =
        Player.getPlayerInstance().getCharacter().getDeck().getHand();
    return hand.where((card) => card.type != CardType.attack).toList().isEmpty;
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
    }
  }
}
