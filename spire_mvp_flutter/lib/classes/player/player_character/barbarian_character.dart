import 'package:spire_mvp_flutter/classes/card/bash.card.dart';
import 'package:spire_mvp_flutter/classes/card/defend.card.dart';
import 'package:spire_mvp_flutter/classes/card/headbutt.card.dart';
import 'package:spire_mvp_flutter/classes/card/strike.card.dart';
import 'package:spire_mvp_flutter/classes/items/block.potion.dart';
import 'package:spire_mvp_flutter/classes/items/fear.potion.dart';
import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_serpent.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_snake.relic.dart';

import '../../deck.dart';
import 'player_character.dart';

class Barbarian extends PlayerCharacter {
  Barbarian() : super() {
    health = 200;
    maxHealth = 200;
    name = 'Barbarian';

    relics = [BurningBloodRelic()];

    items = [];

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
