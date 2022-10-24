import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/body_slam.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/doubt.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class SearingBlow extends PlayableCard {
  int baseDamage = 12;
  int damageIncrease = 0;

  SearingBlow(
      {cardName = 'Searing Blow',
      cardDescription = 'Deal 12 damage.Can be Upgraded any number of times.',
      cardMana = 2,
      cardDamage = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack) {
    damageIncrease = cardDamage;
  }

  @override
  bool isCardCanBeUpgraded() => true;

  @override
  PlayableCard upgradeCard() {
    return SearingBlow(cardDamage: damageIncrease + 1);
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
  StatelessWidget getCardDescription() {
    int damage = baseDamage + damageIncrease;
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
          HighlightDescriptionText(text: 'Can be Upgraded any number of times.')
        ],
      ),
    );
  }

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && mana == 1) return 0;

    return mana;
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    int damage = baseDamage + damageIncrease;
    int finalDamage =
        calculateDamage(damage: damage, precision: precision, mana: mana);
    if (target.length == 1) {
      target[0].recieveDamage(finalDamage);
    }
  }
}
