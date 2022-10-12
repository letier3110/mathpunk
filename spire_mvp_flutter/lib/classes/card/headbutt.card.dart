import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/headbutt.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/deck.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class HeadbuttCard extends PlayableCard {
  int damage = 9;
  int maxSelectableCards = 1;

  HeadbuttCard(
      {cardName = 'Headbutt',
      cardDescription =
          'Deal 9(12) damage. Place a card from your discard pile on top of your draw pile.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardSteps: 1,
            cardMaxSteps: 3,
            cardTemporary: cardTemporary,
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: HeadbuttUpgradeCard());

  @override
  StatelessWidget getCardDescription() {
    int finalDamage = predictDamage(damage: damage, mana: mana);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const Text(
              'Place a card from your discard pile on top of your draw pile.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  List<PlayableCard> getSelectableCards() {
    return Player.getPlayerInstance().getCharacter().getDeck().getDiscardPile();
  }

  @override
  int getMaxSelectableCards() {
    int localMaxSelectableCards = maxSelectableCards;
    return localMaxSelectableCards;
  }

  @override
  bool isCardBoosted() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();
    double mathMultiplierScore =
        castStatusToDouble(statuses, MathMultiplierScoreStatus);
    return mathMultiplierScore > 0;
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    if (step == 1) {
      if (target.length == 1) {
        target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
        step++;
        targetType = TargetEnum.cardTarget;
      }
    } else {
      if (selectedCards.isNotEmpty) {
        Deck deck = character.getDeck();
        List<PlayableCard> discardPile = deck.getDiscardPile();
        List<PlayableCard> drawPile = deck.getDrawPile();

        drawPile.insert(0, selectedCards[0]);
        discardPile.remove(selectedCards[0]);
        setSelectedCards([]);
      }
      targetType = TargetEnum.singleTarget;
      step = 1;
    }
  }
}
