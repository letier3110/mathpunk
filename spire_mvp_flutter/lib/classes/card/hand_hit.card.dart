import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/hand_hit.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class HandHitCard extends PlayableCard {
  int damage = 2;

  HandHitCard(
      {cardName = 'Hand Hit',
      cardDescription = '0 mana, 50% precision, 1 damage',
      cardMana = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: HandHitUpgradeCard(),
            cardPrecision: 80);

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.handHitCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int finalDamage = predictDamage(damage: damage, mana: mana);
    int finalPrecision = predictPrecision(precision: precision);
    return Container(
      child: Column(
        children: [
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
                            : Colors.white)),
            TextSpan(
                text: AppLocalizations.of(context)!.damageEffectDescriptionEnd),
            TextSpan(
                text: AppLocalizations.of(context)!.precisionStartDescription),
            TextSpan(
                text: AppLocalizations.of(context)!
                    .dealPercentageNumber(finalPrecision.toString()),
                style: TextStyle(
                    color: finalPrecision > precision
                        ? Colors.greenAccent
                        : finalPrecision < precision
                            ? Colors.redAccent
                            : Colors.white)),
            TextSpan(
                text: AppLocalizations.of(context)!
                    .percentageEffectDescriptionEnd),
          ])),
        ],
      ),
    );
    // TODO: replace description with highlighted middle part in next lines
    // return Container(
    //   child: Column(
    //     children: [
    //       RichText(
    //           text: TextSpan(children: [
    //         TextSpan(text: AppLocalizations.of(context)!.dealStartDescription),
    //         TextSpan(
    //             text: AppLocalizations.of(context)!
    //                 .dealDamageNumber(finalDamage.toString()),
    //             style: TextStyle(
    //                 color: finalDamage > damage
    //                     ? Colors.greenAccent
    //                     : finalDamage < damage
    //                         ? Colors.redAccent
    //                         : Colors.white)),
    //         TextSpan(
    //             text: AppLocalizations.of(context)!.damageEffectDescriptionEnd),
    //       ])),
    //       HighlightDescriptionText(
    //           text: AppLocalizations.of(context)!.precisionStartDescription),
    //       RichText(
    //           text: TextSpan(children: [
    //         TextSpan(
    //             text: AppLocalizations.of(context)!
    //                 .dealPercentageNumber(finalPrecision.toString()),
    //             style: TextStyle(
    //                 color: finalPrecision > precision
    //                     ? Colors.greenAccent
    //                     : finalPrecision < precision
    //                         ? Colors.redAccent
    //                         : Colors.white)),
    //         TextSpan(
    //             text: AppLocalizations.of(context)!
    //                 .percentageEffectDescriptionEnd),
    //       ])),
    //     ],
    //   ),
    // );
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
  bool isCardBoosted() => true;

  @override
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    if (target.length == 1) {
      target[0].receiveDamage(
          calculateDamage(damage: damage, precision: precision, mana: mana));
    }
  }
}
