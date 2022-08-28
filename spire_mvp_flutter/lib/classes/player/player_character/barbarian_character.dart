import 'package:spire_mvp_flutter/classes/card/bash.card.dart';
import 'package:spire_mvp_flutter/classes/card/blood_for_blood.card.dart';
import 'package:spire_mvp_flutter/classes/card/defend.card.dart';
import 'package:spire_mvp_flutter/classes/card/strike.card.dart';
import 'package:spire_mvp_flutter/classes/items/block.potion.dart';
import 'package:spire_mvp_flutter/classes/items/cunning.potion.dart';
import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';

import '../../deck.dart';
import 'player_character.dart';

class Barbarian extends PlayerCharacter {
  Barbarian() : super() {
    health = 200;
    maxHealth = 200;
    name = 'Barbarian';

    relics = [BurningBloodRelic()];

    items = [CunningPotion(), BlockPotion()];

    final cards = [
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      BloodForBloodCard()
    ];

    deck = Deck(cards);
  }
}
