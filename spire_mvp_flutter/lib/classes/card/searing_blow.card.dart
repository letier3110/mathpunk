import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class SearingBlow extends PlayableCard {
  int baseDamage = 12;
  int damageIncrease = 0;

  SearingBlow(
      {cardName = 'Searing Blow',
      cardDescription = 'Deal 12 damage.Can be Upgraded any number of times.',
      cardMana = 2,
      cardDamage = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack) {
    damageIncrease = cardDamage;
  }

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      damageIncrease > baseDamage
          ? AppLocalizations.of(context)!.searingBlowCardUpgradeName
          : AppLocalizations.of(context)!.searingBlowCardName,
      style: damageIncrease > baseDamage
          ? TextStyle(color: getUpgradedCardColor(), fontSize: 16)
          : const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  bool isCardCanBeUpgraded() => true;

  @override
  PlayableCard upgradeCard() {
    return SearingBlow(cardDamage: damageIncrease + 1);
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
  StatelessWidget getCardDescription(BuildContext context) {
    int damage = baseDamage + damageIncrease;
    int finalDamage = predictDamage(damage: damage, mana: mana);
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
                text: AppLocalizations.of(context)!.damageEffectDescriptionEnd)
          ])),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .multipleUpgradeEffectDescription)
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
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    int damage = baseDamage + damageIncrease;
    int finalDamage =
        calculateDamage(damage: damage, precision: precision, mana: mana);
    if (target.length == 1) {
      target[0].receiveDamage(finalDamage);
    }
  }
}
