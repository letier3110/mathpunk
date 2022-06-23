import '../../relic.dart';
import 'player_character.dart';

class Warrior extends PlayerCharacter {
  Warrior() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Warrior';

    relics = [Relic()];

    // const cards: Card[] = [StrikeCard];
    // this.deck = new Deck(cards);
  }
}
