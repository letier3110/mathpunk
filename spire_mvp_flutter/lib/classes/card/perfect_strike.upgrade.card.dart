import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/deck.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

int damage = 6;
int damageAddition = 3;

class PerfectStrikeUpgradeCard extends PlayableCard {
  PerfectStrikeUpgradeCard(
      {cardName = 'Perfect Strike+',
      cardDescription =
          'Deal 6 damage. Deals an additional 2(3) damage for ALL of your cards containing "Strike".',
      cardMana = 2})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardName() {
    return Text(
      name,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localDamage = predictDamage(damage: damage);
    Deck deck = character.getDeck();
    List<PlayableCard> drawPile = deck.getDrawPile();
    List<PlayableCard> hand = deck.getHand();
    List<PlayableCard> discardPile = deck.getDiscardPile();
    int bonusDamage = 0;
    for (PlayableCard card in drawPile) {
      if (card.name.contains('Strike')) {
        bonusDamage += damageAddition;
      }
    }
    for (PlayableCard card in hand) {
      if (card.name.contains('Strike')) {
        bonusDamage += damageAddition;
      }
    }
    for (PlayableCard card in discardPile) {
      if (card.name.contains('Strike')) {
        bonusDamage += damageAddition;
      }
    }
    int finalDamage = localDamage + bonusDamage;
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
          HighlightDescriptionText(
              text:
                  'Deals an additional $damageAddition damage for ALL of your cards containing "Strike".'),
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
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localDamage = calculateDamage(damage: damage);
    Deck deck = character.getDeck();
    List<PlayableCard> drawPile = deck.getDrawPile();
    List<PlayableCard> hand = deck.getHand();
    List<PlayableCard> discardPile = deck.getDiscardPile();
    int bonusDamage = 0;
    for (PlayableCard card in drawPile) {
      if (card.name.contains('Strike')) {
        bonusDamage += damageAddition;
      }
    }
    for (PlayableCard card in hand) {
      if (card.name.contains('Strike')) {
        bonusDamage += damageAddition;
      }
    }
    for (PlayableCard card in discardPile) {
      if (card.name.contains('Strike')) {
        bonusDamage += damageAddition;
      }
    }
    int finalDamage = localDamage + bonusDamage;
    if (target.length == 1) {
      target[0].recieveDamage(finalDamage);
    }
  }
}
