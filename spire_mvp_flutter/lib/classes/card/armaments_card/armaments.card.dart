import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_card/armaments_card.stats.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_upgrade_card/armaments.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_card/armaments_card.description.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_card/armaments_card.name.dart';
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

class ArmamentsCard extends PlayableCard {
  ArmamentsCard(
      {cardName = 'Armaments',
      cardDescription =
          'Gain 5 Icon Block.png Block.Upgrade a card in your hand for the rest of combat.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.skill,
            cardTargetType: TargetEnum.cardTarget,
            cardUpgrageLink: ArmamentsUpgradeCard(),
            cardTemporary: cardTemporary);

  @override
  StatefulWidget getCardName() {
    return const ArmamentsCardName();
  }

  @override
  StatefulWidget getCardDescription() {
    return const ArmamentsCardDescription();
  }

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && ArmamentsCardStats.mana == 1) return 0;

    return ArmamentsCardStats.mana;
  }

  @override
  List<PlayableCard> getSelectableCards() {
    return Player.getPlayerInstance()
        .getCharacter()
        .getDeck()
        .getHand()
        .where((card) => card.isCardCanBeUpgraded() && card != this)
        .toList();
  }

  @override
  int getMaxSelectableCards() {
    int localMaxSelectableCards = ArmamentsCardStats.maxSelectableCards;
    return localMaxSelectableCards;
  }

  @override
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    if (selectedCards.isNotEmpty) {
      int finalBlock = calculateBlock(
          character: playerCharacter.getCharacter(),
          block: ArmamentsCardStats.block,
          mana: ArmamentsCardStats.mana);

      BlockStatus bs = BlockStatus();
      bs.addStack(finalBlock.toDouble());
      playerCharacter.addStatus(bs);

      PlayableCard upgradedCard = selectedCards[0].upgradeCard();
      playerCharacter.insertNewCardInHandAndRemoveOther(
          upgradedCard, selectedCards[0]);

      setSelectedCards([]);
    }
  }
}


// // click card
// apply 5 block to player
// select card from hand
// upgrade selected card