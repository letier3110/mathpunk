import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/blood_for_blood.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class BloodForBloodCard extends PlayableCard {
  int damage = 18;
  int baseManaCost = 4;

  BloodForBloodCard({
    cardName = 'Blood for Blood',
    cardDescription =
        'Costs 1 less mana for each time you lose HP this combat.Deal 18 damage.',
    cardMana = 4,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: BloodForBloodUpgradeCard());

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int delta = baseManaCost - character.timesReceivedDamageInRound;
    return delta > 0 ? delta : 0;
  }

  @override
  StatelessWidget getCardDescription() {
    int finalDamage = predictDamage(damage: damage, mana: baseManaCost);
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
  bool isCardBoosted() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();
    double mathMultiplierScore =
        castStatusToDouble(statuses, MathMultiplierScoreStatus);
    return mathMultiplierScore > 0;
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0]
          .recieveDamage(calculateDamage(damage: damage, mana: baseManaCost));
    }
  }
}
