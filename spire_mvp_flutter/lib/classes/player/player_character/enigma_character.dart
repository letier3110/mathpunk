import '../../relic.dart';
import 'player_character.dart';

class Enigma extends PlayerCharacter {
  Enigma() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Enigma';

    relics = [Relic()];

    // const cards: Card[] = [StrikeCard];
    // this.deck = new Deck(cards);
  }
}
