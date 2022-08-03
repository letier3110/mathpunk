import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 4;

class ShivCard extends PlayableCard {
  ShivCard(
      {cardName = 'Shiv',
      cardDescription = 'Deal 4 damage.Exhaust.',
      cardMana = 1,
      cardDamage = 4})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardExhaused: true,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    int finalDamage = calculateDamage(damage: damage, mana: mana);
    return Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            const TextSpan(text: 'Deal '),
            TextSpan(
                text: finalDamage.toString(),
                style: TextStyle(
                    color: finalDamage > damage
                        ? Colors.greenAccent
                        : finalDamage < damage
                            ? Colors.redAccent
                            : Colors.white)),
            const TextSpan(text: ' damage.')
          ])),
          HighlightDescriptionText(text: 'Exhaust.'),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
    }
  }
}
