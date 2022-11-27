import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/card/anger_upgrade_card/anger.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.stats.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/cards_played_in_round.card_effect%20copy.dart';
import 'package:mathpunk_cardgame/classes/card_effects/copy_card_discard.card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/deal_damage.card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/mana_draw.card_effect.dart';
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
              ManaDrawCardEffect(),
              CardsPlayedInRoundCardEffect(),
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
  bool isCardBoosted() => true;
}

// // click card
// select target
// deal damage to target
// add copy of card to discard pile