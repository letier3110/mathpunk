import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/body_slam.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class BodySlamCard extends PlayableCard {
  BodySlamCard(
      {cardName = 'Body Slam',
      cardDescription = 'Deal damage equal to your current Block.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: BodySlamUpgradeCard(),
            cardTemporary: cardTemporary);

  @override
  StatelessWidget getCardDescription() {
    return HighlightDescriptionText(
        text: 'Deal damage equal to your current Block.');
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
      List<Status> statuses = character.getStatuses();
      int block = castStatusToInt(statuses, BlockStatus);
      target[0].recieveDamage(
          calculateDamage(damage: block, precision: precision, mana: mana));
    }
  }
}
