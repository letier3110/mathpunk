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

    final cards = [StrikeCard()];
    deck = Deck(cards);
  }
}
