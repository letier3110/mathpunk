import '../../card/cards_implementation.dart';
import '../../deck.dart';
import '../../relic.dart';
import 'player_character.dart';

class Mage extends PlayerCharacter {
  Mage() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Mage';

    relics = [Relic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
