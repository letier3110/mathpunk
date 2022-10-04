import 'package:mathpunk_cardgame/classes/card/armaments.card.dart';
import 'package:mathpunk_cardgame/classes/card/armaments.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/double.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/triple.math.card.dart';
import 'package:mathpunk_cardgame/classes/relic/chess_pyramid.relic.dart';

import '../../deck.dart';
import 'player_character.dart';

class Priest extends PlayerCharacter {
  Priest() : super() {
    health = 75;
    maxHealth = 75;
    name = 'Priest';

    relics = [ChessPyramid()];

    final cards = [
      DoubleMathCard(),
      DoubleMathCard(),
      TripleMathCard(),
      ArmamentsCard(),
      ArmamentsUpgradeCard()
    ];
    deck = Deck(cards);
  }
}
