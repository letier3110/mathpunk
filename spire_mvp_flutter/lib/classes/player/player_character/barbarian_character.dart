import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';

import '../../card/cards_implementation.dart';
import '../../deck.dart';
import 'player_character.dart';

class Barbarian extends PlayerCharacter {
  Barbarian() : super() {
    health = 200;
    maxHealth = 200;
    name = 'Barbarian';

    relics = [BurningBloodRelic()];

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
