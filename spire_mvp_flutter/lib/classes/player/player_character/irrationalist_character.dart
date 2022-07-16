import '../../card/cards_implementation.dart';
import '../../deck.dart';

import '../../relic/burning_blood.relic.dart';
import 'player_character.dart';

class Irrationalist extends PlayerCharacter {
  Irrationalist() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Irrationalist';

    relics = [BurningBloodRelic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
