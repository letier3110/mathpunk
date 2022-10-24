import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/iron_wave.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import '../util.dart';
import 'playable_card.dart';

class IronWaveCard extends PlayableCard {
  int damage = 5;
  int block = 5;

  IronWaveCard(
      {cardName = 'Iron Wave',
      cardDescription = 'Gain 5(7) Block. Deal 5(7) damage.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: IronWaveUpgradeCard());

  @override
  StatelessWidget getCardDescription() {
    int localBlock = block;
    int finalDamage = predictDamage(damage: damage, mana: mana);

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
  bool isCardBoosted() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();
    double mathMultiplierScore =
        castStatusToDouble(statuses, MathMultiplierScoreStatus);
    return mathMultiplierScore > 0;
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
    if (target.length == 1) {
      int localBlock = block;
      target[0].recieveDamage(
          calculateDamage(damage: damage, precision: precision, mana: mana));

      BlockStatus bs = BlockStatus();
      bs.addStack(localBlock.toDouble());
      character.addStatus(bs);
    }
  }
}
