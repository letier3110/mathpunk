import '../../card/cards_implementation.dart';
import '../../deck.dart';
import '../../relic.dart';
import 'player_character.dart';

class Priest extends PlayerCharacter {
  Priest() : super() {
    health = 75;
    maxHealth = 75;
    name = 'Priest';

    relics = [Relic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
