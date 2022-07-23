import 'package:spire_mvp_flutter/classes/card/bash.card.dart';
import 'package:spire_mvp_flutter/classes/card/defend.card.dart';
import 'package:spire_mvp_flutter/classes/card/headbutt.card.dart';
import 'package:spire_mvp_flutter/classes/card/strike.card.dart';
import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';

import '../../deck.dart';
import 'player_character.dart';

class Barbarian extends PlayerCharacter {
  Barbarian() : super() {
    health = 200;
    maxHealth = 200;
    name = 'Barbarian';

    relics = [BurningBloodRelic()];

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
