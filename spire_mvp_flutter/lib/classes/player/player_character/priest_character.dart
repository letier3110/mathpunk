import 'package:mathpunk_cardgame/classes/card/armaments.card.dart';
import 'package:mathpunk_cardgame/classes/card/armaments.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/double.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/triple.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/strike.card.dart';

import '../../deck.dart';
import '../../relic/burning_blood.relic.dart';
import 'player_character.dart';

class Priest extends PlayerCharacter {
  Priest() : super() {
    health = 75;
    maxHealth = 75;
    name = 'Priest';

    relics = [BurningBloodRelic()];

    final cards = [
      DoubleMathCard(),
      DoubleMathCard(),
      TripleMathCard(),
      ArmamentsCard(),
      ArmamentsUpgradeCard()
    ];
    deck = Deck(cards);
  }
}
