import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/card_type.enum.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class DoubleMathUpgradeCard extends PlayableCard {
  DoubleMathUpgradeCard(
      {cardName = '2x+',
      cardDescription = 'Function. Doubles next value',
      cardMana = 2})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.function);

  @override
  StatelessWidget getCardName() {
    return Text(
      name,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription() {
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Function. Doubles next value.'),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addMathMultiplierScore(2);
    if (character.mathMultiplierTime == 0) {
      character.addMathMultiplierTime(1);
    }
  }
}