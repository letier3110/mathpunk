import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/anger.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class ArmamentsUpgradeCard extends PlayableCard {
  int block = 5;

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
  StatelessWidget getCardName() {
    return Text(
      name,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription() {
    int finalBlock = predictBlock(block: block, mana: mana);
    return Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            const TextSpan(text: 'Gain '),
            TextSpan(
                text: finalBlock.toString(),
                style: TextStyle(
                    color: finalBlock > block
                        ? Colors.greenAccent
                        : finalBlock < block
                            ? Colors.redAccent
                            : Colors.white)),
            const TextSpan(text: ' Block.')
          ])),
          HighlightDescriptionText(
              text: 'Upgrade all cards in your hand for the rest of combat.'),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    int finalBlock = calculateBlock(block: block, mana: mana);
    BlockStatus bs = BlockStatus();
    bs.addStack(finalBlock.toDouble());
    character.addStatus(bs);
    List<PlayableCard> hand = character
        .getDeck()
        .getHand()
        .where((card) => card.isCardCanBeUpgraded() && card != this)
        .toList();
    character.getDeck().hand = hand.map((card) => card.upgradeCard()).toList();
  }
}
