import '../../card/bash.card.dart';
import '../../card/defend.card.dart';
import '../../card/headbutt.card.dart';
import '../../card/strike.card.dart';
import '../../deck.dart';

import 'player_character.dart';

class Irrationalist extends PlayerCharacter {
  Irrationalist() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Irrationalist';

    final cards = [
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      StrikeCard(),
      HeadbuttCard(),
      BashCard(),
      DefendCard(),
      DefendCard(),
      DefendCard(),
      DefendCard()
    ];
    deck = Deck(cards);
  }
}
