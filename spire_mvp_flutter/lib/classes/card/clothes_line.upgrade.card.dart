import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/weak.status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class ClothesLineUpgradeCard extends PlayableCard {
  int damage = 14;
  int weak = 3;

  ClothesLineUpgradeCard(
      {cardName = 'Clothesline+',
      cardDescription = 'Deal 12(14) damage. Apply 2(3) Weak.',
      cardMana = 2,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.clotheslineCardUpgradeName,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int localWeak = weak;
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
                            : Colors.white,
                    fontSize: 14)),
            TextSpan(
                text: AppLocalizations.of(context)!.damageEffectDescriptionEnd)
          ])),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .applyWeakEffectDescription(localWeak.toString())),
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
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && mana == 1) return 0;

    return mana;
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    if (target.length == 1) {
      target[0].recieveDamage(
          calculateDamage(damage: damage, precision: precision, mana: mana));
      WeakStatus ws = WeakStatus();
      ws.addStack(weak.toDouble());
      target[0].addStatus(ws);
    }
  }
}
