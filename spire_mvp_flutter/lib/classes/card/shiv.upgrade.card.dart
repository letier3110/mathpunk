import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class ShivUpgradeCard extends PlayableCard {
  int damage = 6;

  ShivUpgradeCard(
      {cardName = 'Shiv+',
      cardDescription = 'Deal 6 damage. Exhaust.',
      cardMana = 1})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardExhaused: true,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardName() {
    return Text(
      name,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription() {
    int finalDamage = predictDamage(damage: damage, mana: mana);
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
  bool isCardBoosted() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    return character.mathMultiplierScore > 0;
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
    }
  }
}
