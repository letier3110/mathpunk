import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/card/anger_upgrade_card/anger.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.stats.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/copy_card_discard.card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/deal_damage.card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/select_target.card_effect.dart';
import 'package:mathpunk_cardgame/components/card_name.dart';
import 'package:mathpunk_cardgame/enums/card_type.enum.dart';

class AngerCard extends PlayableCard {
  AngerCard({
    cardMana = 1,
    cardTemporary = false,
  }) : super(
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: AngerUpgradeCard(),
            cardTemporary: cardTemporary,
            cardEffect: [
              SelectTargetCardEffect(),
              DealDamageCardEffect(
                  damage: AngerCardStats.damage, mana: AngerCardStats.mana),
              CopyCardDiscardCardEffect()
            ]);

  @override
  StatefulWidget getCardName(BuildContext context) {
    return CardName(
      isUpgraded: false,
      name: AppLocalizations.of(context)!.angerCardName,
    );
  }

  @override
  int getMana() {
    // List<Status> statuses = character.getStatuses();
    // bool isBishopStatus = castStatusToBool(statuses, BishopStatus);
    // if (isBishopStatus && AngerCardStats.mana == 1) return 0;
    return AngerCardStats.mana;
  }

  @override
  bool isCardBoosted() => true;

  // @override
  // play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
  //   if (target.length == 1) {
  //     target[0].receiveDamage(calculateDamage(
  //         character: playerCharacter.getCharacter(),
  //         damage: AngerCardStats.damage,
  //         precision: precision,
  //         mana: AngerCardStats.mana));
  //   }
  //   playerCharacter.addCardToDiscardPile(this);
  // }
}

// // click card
// select target
// deal damage to target
// add copy of card to discard pile