import 'package:spire_mvp_flutter/classes/relic/ring_of_snake.relic.dart';

import '../../card/cards_implementation.dart';
import '../../deck.dart';

import 'player_character.dart';

class Irrationalist extends PlayerCharacter {
  Irrationalist() : super() {
    health = 100;
    maxHealth = 100;
    name = 'Irrationalist';

    relics = [RingOfSnake()];

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
