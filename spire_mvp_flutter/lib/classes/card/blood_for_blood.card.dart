import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/blood_for_blood.upgrade.card.dart';
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

class BloodForBloodCard extends PlayableCard {
  int damage = 18;
  int baseManaCost = 4;

  BloodForBloodCard(
      {cardName = 'Blood for Blood',
      cardDescription =
          'Costs 1 less mana for each time you lose HP this combat.Deal 18 damage.',
      cardMana = 4,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: BloodForBloodUpgradeCard(),
            cardTemporary: cardTemporary);

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int delta = baseManaCost - character.timesReceivedDamageInRound;

    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && delta == 1) return 0;

    return delta > 0 ? delta : 0;
  }

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.bloodForBloodCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int finalDamage = predictDamage(damage: damage, mana: baseManaCost);
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
            text: AppLocalizations.of(context)!
                .costLessForEachHpLooseEffectDescription,
            fontSize: 14,
          ),
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
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(
          damage: damage, precision: precision, mana: baseManaCost));
    }
  }
}
