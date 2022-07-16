import '../../card/cards_implementation.dart';
import '../../deck.dart';
import '../../relic/burning_blood.relic.dart';
import '../../relic/relic.dart';
import 'player_character.dart';

class Priest extends PlayerCharacter {
  Priest() : super() {
    health = 75;
    maxHealth = 75;
    name = 'Priest';

    relics = [BurningBloodRelic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
