import 'package:mathpunk_cardgame/classes/card/anger.card.dart';
import 'package:mathpunk_cardgame/classes/card/anger.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/blood_for_blood.card.dart';
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

    final cards = [
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      BloodForBloodCard(),
      AngerCard(),
      AngerUpgradeCard()
    ];

    deck = Deck(cards);
  }
}
