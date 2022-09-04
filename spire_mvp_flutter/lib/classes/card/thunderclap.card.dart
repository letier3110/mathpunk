import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 4;
int vulnerable = 1;

class ThunderclapCard extends PlayableCard {
  ThunderclapCard({
    cardName = 'Thunderclap',
    cardDescription = 'Deal 4(7) damage and apply 1 Vulnerable to ALL enemies.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    int localVulnerable = vulnerable;
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
            TextSpan(
                text:
                    ' damage and apply $localVulnerable Vulnerable to ALL enemies.')
          ]))
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.recieveDamage(calculateDamage(damage: damage, mana: mana));
      int localVulnerable = vulnerable;
      target[0].addVulnerable(localVulnerable);
    }
  }
}
