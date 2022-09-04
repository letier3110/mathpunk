import 'package:mathpunk_cardgame/classes/relic/ring_of_serpent.relic.dart';

import '../../card/bash.card.dart';
import '../../card/defend.card.dart';
import '../../card/headbutt.card.dart';
import '../../card/strike.card.dart';
import '../../deck.dart';
import 'player_character.dart';

class Enigma extends PlayerCharacter {
  Enigma() : super() {
    health = 70;
    maxHealth = 70;
    name = 'Enigma';

    relics = [RingOfSerpent()];

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
