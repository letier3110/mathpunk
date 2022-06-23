import 'package:spire_mvp_flutter/classes/card/attack_card_type.dart';

import '../base_character.dart';

import '../../enums/card_type.dart';
import 'card.dart';

class AttackCard extends Card {
  late int damage;
  late AttackCardType subtype;

  AttackCard(
      {required cardName,
      required cardDescription,
      cardMana = 0,
      cardSubType = AttackCardType.singleTarget,
      cardDamage = 10})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack) {
    damage = cardDamage;
    subtype = cardSubType;
  }

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.changeHealth(-damage);
    }
  }
}
