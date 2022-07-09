import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

int damage = 10;

class AttackCard extends PlayableCard {
  AttackCard({
    required cardName,
    required cardDescription,
    cardMana = 0,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardTargetType: TargetEnum.singleTarget);

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.changeHealth(-damage);
    }
  }
}
