import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.dart';
import 'playable_card.dart';

class AttackCard extends PlayableCard {
  late int damage;

  AttackCard(
      {required cardName,
      required cardDescription,
      cardMana = 0,
      cardDamage = 10})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardTargetType: TargetEnum.singleTarget) {
    damage = cardDamage;
  }

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.changeHealth(-damage);
    }
  }
}
