import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/anger_upgrade_card/anger_upgrade_card.description.dart';
import 'package:mathpunk_cardgame/classes/card/anger_upgrade_card/anger_upgrade_card.name.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_upgrade_card/armaments_upgrade_card.stats.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';

import '../../base_character.dart';

import '../../../enums/card_type.enum.dart';
import '../../util.dart';
import '../playable_card.dart';

class AngerUpgradeCard extends PlayableCard {
  AngerUpgradeCard(
      {cardName = 'Anger+',
      cardDescription = 'Deal 9 damage.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardTemporary: cardTemporary);

  @override
  StatefulWidget getCardName() {
    return const AngerUpgradeCardName();
  }

  @override
  StatefulWidget getCardDescription() {
    return const AngerUpgradeCardDescription();
  }

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && ArmamentsUpgradeCardStats.mana == 1) return 0;

    return ArmamentsUpgradeCardStats.mana;
  }

  @override
  bool isCardBoosted() => true;

  @override
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    if (target.length == 1) {
      target[0].receiveDamage(calculateDamage(
          character: playerCharacter.getCharacter(),
          damage: ArmamentsUpgradeCardStats.block,
          precision: precision,
          mana: ArmamentsUpgradeCardStats.mana));
    }
    playerCharacter.addCardToDiscardPile(this);
  }
}
