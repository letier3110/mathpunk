import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/defend.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

class DefendCard extends PlayableCard {
  int block = 5;

  DefendCard(
      {cardName = 'Defend',
      cardDescription = 'Gain 5 Block.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardTemporary: cardTemporary,
            cardMana: cardMana,
            cardType: CardType.skill,
            cardTargetType: TargetEnum.allTargets,
            cardUpgrageLink: DefendUpgradeCard());

  @override
  StatelessWidget getCardDescription() {
    var localBlock = block;
    return HighlightDescriptionText(text: 'Gain $localBlock Block.');
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    BlockStatus bs = BlockStatus();
    bs.addStack(block.toDouble());
    character.addStatus(bs);
  }
}
