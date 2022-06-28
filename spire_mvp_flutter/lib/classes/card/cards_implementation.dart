import 'package:spire_mvp_flutter/classes/card/bash.card.dart';
import 'package:spire_mvp_flutter/classes/card/strike.card.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import 'attack_card.dart';

final strikeCard = StrikeCard();

final bashCard = BashCard();

final defendCard = AttackCard(
  cardName: 'Defend',
  cardDescription: 'Gain 5 Block',
  cardMana: 1,
  cardDamage: 4,
);
