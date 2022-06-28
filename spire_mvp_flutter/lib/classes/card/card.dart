import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.dart';

class Card {
  late String name;
  late String description;
  late int mana;
  late CardType type;
  late TargetEnum targetType = TargetEnum.singleTarget;

  Card(
      {cardName = '',
      cardDescription = '',
      cardMana = 0,
      cardType = CardType.skill,
      cardTargetType = TargetEnum.singleTarget}) {
    name = cardName;
    description = cardDescription;
    mana = cardMana;
    type = cardType;
    targetType = cardTargetType;
  }

  String getCardName() {
    return name;
  }

  String getCardDescription() {
    return description;
  }

  play(List<BaseCharacter> target) {
    // console.log(targets);
    // TODO: implement card apply effect to enemy
  }
}
