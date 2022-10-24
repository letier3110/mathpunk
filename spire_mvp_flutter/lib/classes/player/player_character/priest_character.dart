import 'package:mathpunk_cardgame/classes/card/cloak_cover.card.dart';
import 'package:mathpunk_cardgame/classes/card/hand_hit.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/double.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/triple.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/stick_hit.card.dart';
import 'package:mathpunk_cardgame/classes/card/throw_stone.card.dart';
import 'package:mathpunk_cardgame/classes/relic/chess_pyramid.relic.dart';

import '../../deck.dart';
import 'player_character.dart';

class Priest extends PlayerCharacter {
  Priest() : super() {
    health = 75;
    maxHealth = 75;
    manaPower = 100;
    mana = 100;
    name = 'Priest';

    relics = [ChessPyramid()];

    final cards = [
      StickHitCard(),
      StickHitCard(),
      StickHitCard(),
      HandHitCard(),
      HandHitCard(),
      ClockCoverCard(),
      ThrowStoneCard(),
      DoubleMathCard(),
      DoubleMathCard(),
      DoubleMathCard(),
      TripleMathCard(),
    ];
    deck = Deck(cards);
  }

  @override
  startTurn() {
    deck.draw(drawPower);
    // mana = manaPower;
  }
}
