import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 18;
int mana = 4;

class BloodForBloodCard extends PlayableCard {
  BloodForBloodCard({
    cardName = 'Blood for Blood',
    cardDescription =
        'Costs 1 less mana for each time you lose HP this combat.Deal 18 damage.',
    cardMana = 4,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int delta = mana - character.timesReceivedDamageInRound;
    return delta > 0 ? delta : 0;
  }

  @override
  StatelessWidget getCardDescription() {
    int finalDamage = calculateDamage(damage: damage, mana: mana);
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
            text: 'Costs 1 less mana for each time you lose HP this combat.',
            fontSize: 14,
          ),
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
                            : Colors.white,
                    fontSize: 14)),
            const TextSpan(text: ' damage.')
          ]))
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
