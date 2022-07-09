import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';

class PlayableCard {
  late String name;
  late String description;
  late int mana;
  late CardType type;
  late TargetEnum targetType = TargetEnum.singleTarget;

  PlayableCard(
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

  bool disposeToDiscard(
      List<PlayableCard> hand, List<PlayableCard> discardPile) {
    discardPile.add(this);
    hand.remove(this);
    return true;
  }

  play(List<BaseCharacter> target) {
    // console.log(targets);
    // TODO: implement card apply effect to enemy
  }

  factory PlayableCard.fromJson(dynamic json) {
    return PlayableCard(
        cardName: json['name'] as String,
        cardDescription: json['description'] as String,
        cardMana: json['mana'] as int,
        cardType: decodeCardTypeFromJson(json['type']),
        cardTargetType: decodeTargetEnumFromJson(json['targetType']));
  }

  Map toJson() => {
        'name': name,
        'description': description,
        'mana': mana,
        'type': type.toString(),
        'targetType': targetType.toString(),
      };
}
