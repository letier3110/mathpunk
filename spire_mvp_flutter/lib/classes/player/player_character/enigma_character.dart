import 'package:spire_mvp_flutter/classes/relic/ring_of_serpent.relic.dart';

import '../../card/cards_implementation.dart';
import '../../deck.dart';
import 'player_character.dart';

class Enigma extends PlayerCharacter {
  Enigma() : super() {
    health = 70;
    maxHealth = 70;
    name = 'Enigma';

    relics = [RingOfSerpent()];

    final cards = [
      strikeCard,
      strikeCard,
      strikeCard,
      strikeCard,
      bashCard,
      defendCard,
      defendCard,
      defendCard,
      defendCard
    ];
    deck = Deck(cards);
  }
}
