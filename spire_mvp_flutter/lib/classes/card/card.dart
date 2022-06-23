import '../base_character.dart';

import '../../enums/card_type.dart';

class Card {
  late String name;
  late String description;
  late int mana;
  late String type;

  Card(
      {cardName = '',
      cardDescription = '',
      cardMana = 0,
      cardType = CardType.skill}) {
    name = cardName;
    description = cardDescription;
    mana = cardMana;
    type = cardType;
  }

  play(List<BaseCharacter> target) {
    // console.log(targets);
    // TODO: implement card apply effect to enemy
  }
}
