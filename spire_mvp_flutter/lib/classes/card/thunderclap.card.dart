import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/thunderclap.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/vulnerable.status.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class ThunderclapCard extends PlayableCard {
  int damage = 4;
  int vulnerable = 1;

  ThunderclapCard(
      {cardName = 'Thunderclap',
      cardDescription =
          'Deal 4(7) damage and apply 1 Vulnerable to ALL enemies.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.attack,
            cardUpgrageLink: ThunderclapUpgradeCard());

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.thunderclapCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int localVulnerable = vulnerable;
    int finalDamage = predictDamage(damage: damage, mana: mana);
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .addWeakAndDealDamageEffectDescription(
                      finalDamage.toString(), localVulnerable.toString())),
        ],
      ),
    );
  }

  @override
  bool isCardBoosted() => true;

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
    for (var t in target) {
      t.receiveDamage(
          calculateDamage(damage: damage, precision: precision, mana: mana));
      int localVulnerable = vulnerable;
      VulnerableStatus vs = VulnerableStatus();
      vs.addStack(localVulnerable.toDouble());
      target[0].addStatus(vs);
    }
  }
}

// // click card
// deal damage to all enemies
// apply weak to all enemies