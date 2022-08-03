import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 5;
int block = 5;

class IronWaveCard extends PlayableCard {
  IronWaveCard(
      {cardName = 'Iron Wave',
      cardDescription = 'Gain 5(7) Block. Deal 5(7) damage.',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    int localBlock = block;
    int finalDamage = calculateDamage(damage: damage, mana: mana);

    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Gain $localBlock Block.'),
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
          ]))
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      PlayerCharacter character = Player.getPlayerInstance().getCharacter();
      int localBlock = block;
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
      character.addBlock(localBlock);
    }
  }
}
