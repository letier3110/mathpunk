import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/clash.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class ClashCard extends PlayableCard {
  int damage = 14;

  ClashCard(
      {cardName = 'Clash',
      cardDescription =
          'Can only be played if every card in your hand is an Attack. Deal 14(18) damage.',
      cardMana = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: ClashUpgradeCard(),
            cardTemporary: cardTemporary);

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.clashCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int finalDamage = predictDamage(damage: damage, mana: mana);
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .canBePlayedIfOnlyAttackInHandEffectDescription),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: AppLocalizations.of(context)!.dealStartDescription),
            TextSpan(
                text: AppLocalizations.of(context)!
                    .dealDamageNumber(finalDamage.toString()),
                style: TextStyle(
                    color: finalDamage > damage
                        ? Colors.greenAccent
                        : finalDamage < damage
                            ? Colors.redAccent
                            : Colors.white,
                    fontSize: 14)),
            TextSpan(
                text: AppLocalizations.of(context)!.damageEffectDescriptionEnd)
          ]))
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
  bool isCardPlayable() {
    List<PlayableCard> hand =
        Player.getPlayerInstance().getCharacter().getDeck().getHand();
    return hand.where((card) => card.type != CardType.attack).toList().isEmpty;
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    if (target.length == 1) {
      target[0].recieveDamage(
          calculateDamage(damage: damage, precision: precision, mana: mana));
    }
  }
}
