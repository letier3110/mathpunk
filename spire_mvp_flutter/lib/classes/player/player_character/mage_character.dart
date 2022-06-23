import '../../relic.dart';
import 'player_character.dart';

class Mage extends PlayerCharacter {
  Mage() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Mage';

    relics = [Relic()];

    // const cards: Card[] = [StrikeCard];
    // this.deck = new Deck(cards);
  }
}
