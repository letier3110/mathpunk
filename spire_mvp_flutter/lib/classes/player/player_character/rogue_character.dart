import '../../relic.dart';
import 'player_character.dart';

class Rogue extends PlayerCharacter {
  Rogue() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Rogue';

    relics = [Relic()];

    // const cards: Card[] = [StrikeCard];
    // this.deck = new Deck(cards);
  }
}
