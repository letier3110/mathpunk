import 'package:spire_mvp_flutter/enums/target.enum.dart';

import 'attack_card.dart';

final strikeCard = AttackCard(
  cardName: 'Strike',
  cardDescription: 'Deal 10 damage to target enemy',
  cardMana: 1,
  cardDamage: 10,
);

final bashCard = AttackCard(
  cardName: 'Bash',
  cardDescription: 'Deal 8 damage to target enemy',
  cardMana: 2,
  cardDamage: 8,
);

final sliceCard = AttackCard(
  cardName: 'Slice',
  cardDescription: 'Deal 4 damage to every enemy',
  cardMana: 2,
  cardDamage: 4,
);

final defendCard = AttackCard(
  cardName: 'Defend',
  cardDescription: 'Gain 5 Block',
  cardMana: 1,
  cardDamage: 4,
);
