import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger.card.dart';
import 'package:mathpunk_cardgame/classes/card/anger_upgrade_card/anger.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/blood_for_blood.card.dart';
import 'package:mathpunk_cardgame/classes/card/defend.card.dart';
import 'package:mathpunk_cardgame/classes/card/strike.card.dart';
import 'package:mathpunk_cardgame/classes/items/block.potion.dart';
import 'package:mathpunk_cardgame/classes/items/cunning.potion.dart';
import 'package:mathpunk_cardgame/classes/relic/burning_blood.relic.dart';

import '../../deck.dart';
import 'player_character.dart';

class Barbarian extends PlayerCharacter {
  Barbarian() : super() {
    health = 200;
    maxHealth = 200;
    name = 'Barbarian';

    relics = [BurningBloodRelic()];

    items = [CunningPotion(), BlockPotion()];
    description =
        'A mysterious and dumb barbarian from Southlands of Matri Valley.\nHe relies on his brute force and sharp sword.';

    final cards = [
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      DefendCard(),
      DefendCard(),
      DefendCard(),
      BloodForBloodCard(),
      AngerCard(),
      AngerUpgradeCard()
    ];

    deck = Deck(cards);
  }

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.barbarianName;

  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.barbarianDescription;
}
