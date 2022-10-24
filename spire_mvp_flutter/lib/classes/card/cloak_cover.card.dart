import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/clock_cover.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class ClockCoverCard extends PlayableCard {
  int block = 3;

  ClockCoverCard(
      {cardName = 'Cloak Cover',
      cardDescription = '0 mana, 80% precision, 3 Block',
      cardMana = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill,
            cardUpgrageLink: CloakCoverUpgradeCard(),
            cardPrecision: 80);

  @override
  StatelessWidget getCardDescription() {
    int finalBlock = predictBlock(block: block, mana: mana);
    int finalPrecision = predictPrecision(precision: precision);
    return Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            const TextSpan(text: 'Receive '),
            TextSpan(
                text: finalBlock.toString(),
                style: TextStyle(
                    color: finalBlock > block
                        ? Colors.greenAccent
                        : finalBlock < block
                            ? Colors.redAccent
                            : Colors.white)),
            const TextSpan(text: ' Block. Precision '),
            TextSpan(
                text: finalPrecision.toString(),
                style: TextStyle(
                    color: finalPrecision > precision
                        ? Colors.greenAccent
                        : finalPrecision < precision
                            ? Colors.redAccent
                            : Colors.white)),
            const TextSpan(text: '%.'),
          ])),
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
  bool isCardBoosted() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();
    double mathMultiplierScore =
        castStatusToDouble(statuses, MathMultiplierScoreStatus);
    return mathMultiplierScore > 0;
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    BlockStatus bs = BlockStatus();

    int finalBlock = predictBlock(block: block, mana: mana);
    bs.addStack(finalBlock.toDouble());
    character.addStatus(bs);
  }
}
