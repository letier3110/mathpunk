import '../../card/cards_implementation.dart';
import '../../deck.dart';
import '../../relic.dart';
import 'player_character.dart';

class Rogue extends PlayerCharacter {
  Rogue() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Rogue';

    relics = [Relic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
