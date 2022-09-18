import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/math/mathfunction.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/card_type.enum.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

int damage = 6;

class DoubleMathCard extends PlayableCard {
  DoubleMathCard(
      {cardName = '2x',
      cardDescription = 'Function. Doubles next value',
      cardMana = 5,
      cardDamage = 6})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.function);

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
    // if (target.length == 1) {
    //   target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
    // }
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    Mathfunction? mathfunction = character.getMathfunction();
    if (mathfunction == null) {
      mathfunction = Mathfunction();
      character.addMathFunction(mathfunction);
    }
    Mathfunction doublefunction = Mathfunction(slotsNumber: 1);
    mathfunction.setFirstAvailableSlotMathfunction(doublefunction);
  }
}
