import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/perfect_strike.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/deck.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

class PerfectStrikeCard extends PlayableCard {
  int damage = 6;
  int damageAddition = 3;

  PerfectStrikeCard(
      {cardName = 'Perfect Strike',
      cardDescription =
          'Deal 6 damage. Deals an additional 2(3) damage for ALL of your cards containing "Strike".',
      cardMana = 2,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: PerfectStrikeUpgradeCard());
  @override
  StatelessWidget getCardDescription(BuildContext context) {
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
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && mana == 1) return 0;

    return mana;
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
    int localDamage = calculateDamage(
      damage: damage,
      precision: precision,
    );
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
