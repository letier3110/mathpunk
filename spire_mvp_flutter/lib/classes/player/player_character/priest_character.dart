import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    name = 'Reality Enchanter';
    description =
        'A son of a noble house of math kingdom Noocracy.\nCalls to forces beyond the reality to shape his path.';

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
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.realityEchanterName;

  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.realityEchanterDescription;

  @override
  startTurn() {
    deck.draw(drawPower);
    // mana = manaPower;
  }

  @override
  enterRoom() {
    mana = max(mana, ((manaPower - mana) * 0.9).round());
  }
}
