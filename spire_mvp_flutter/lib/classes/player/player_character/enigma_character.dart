import '../../card/cards_implementation.dart';
import '../../deck.dart';
import '../../relic.dart';
import 'player_character.dart';

class Enigma extends PlayerCharacter {
  Enigma() : super() {
    health = 70;
    maxHealth = 70;
    name = 'Enigma';

    relics = [Relic()];

    final cards = [strikeCard];
    deck = Deck(cards);
  }
}
