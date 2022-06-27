import '../../card/cards_implementation.dart';
import '../../deck.dart';
import '../../relic.dart';
import 'player_character.dart';

class Warrior extends PlayerCharacter {
  Warrior() : super() {
    health = 200;
    maxHealth = 200;
    name = 'Warrior';

    relics = [Relic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
