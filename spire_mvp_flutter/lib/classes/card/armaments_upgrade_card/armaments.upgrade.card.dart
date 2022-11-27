import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_upgrade_card/armaments_upgrade_card.description.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_upgrade_card/armaments_upgrade_card.name.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_upgrade_card/armaments_upgrade_card.stats.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';

import '../../base_character.dart';

import '../../../enums/card_type.enum.dart';
import '../../util.dart';
import '../playable_card.dart';

class ArmamentsUpgradeCard extends PlayableCard {
  ArmamentsUpgradeCard(
      {cardName = 'Armaments+',
      cardDescription =
          'Gain 5 Icon Block.png Block.Upgrade a card in your hand for the rest of combat.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.skill,
            cardTargetType: TargetEnum.allTargets,
            cardTemporary: cardTemporary);

  @override
  StatefulWidget getCardName() {
    return const ArmamentsUpgradeCardName();
  }

  @override
  StatefulWidget getCardDescription() {
    return const ArmamentsUpgradeCardDescription();
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
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    int finalBlock = calculateBlock(
        character: playerCharacter.getCharacter(),
        block: ArmamentsUpgradeCardStats.block,
        mana: ArmamentsUpgradeCardStats.mana);
    BlockStatus bs = BlockStatus();
    bs.addStack(finalBlock.toDouble());
    playerCharacter.addStatus(bs);
    playerCharacter.armamentsPlayEffect(this);
  }
}
