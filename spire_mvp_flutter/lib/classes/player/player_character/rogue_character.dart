import '../../card/cards_implementation.dart';
import '../../deck.dart';
import '../../relic.dart';
import 'player_character.dart';

class Rogue extends PlayerCharacter {
  Rogue() : super() {
    health = 75;
    maxHealth = 75;
    name = 'Rogue';

    relics = [Relic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
