import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/pommel_strike.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 9;
int draw = 1;

class PommelStrikeCard extends PlayableCard {
  PommelStrikeCard(
      {cardName = 'Pommel Strike',
      cardDescription = 'Deal 9(10) damage. Draw 1(2) card(s).',
      cardMana = 1})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: PommelStrikeUpgradeCard());

  @override
  StatelessWidget getCardDescription() {
    int localDraw = draw;
    int finalDamage = predictDamage(damage: damage, mana: mana);
    return Container(
      child: Column(
        children: [
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
          ])),
          HighlightDescriptionText(text: 'Draw $localDraw card.'),
        ],
      ),
    );
  }

  @override
  bool isCardBoosted() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    return character.mathMultiplierScore > 0;
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
      int localDraw = draw;
      PlayerCharacter character = Player.getPlayerInstance().getCharacter();
      character.deck.draw(localDraw);
    }
  }
}
