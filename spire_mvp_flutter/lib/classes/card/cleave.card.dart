import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 8;

class CleaveCard extends PlayableCard {
  CleaveCard({
    cardName = 'Cleave',
    cardDescription = 'Deal 8(11) damage to ALL enemies.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
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
            const TextSpan(text: ' damage to ALL enemies.')
          ])),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.recieveDamage(calculateDamage(damage: damage, mana: mana));
    }
  }
}
