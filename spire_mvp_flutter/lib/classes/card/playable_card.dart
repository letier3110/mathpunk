import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';

class PlayableCard {
  late String name;
  late String description;
  late int mana;
  late CardType type;
  late TargetEnum targetType = TargetEnum.singleTarget;
  bool exhausted = false;
  bool ethereal = false;
  int step = 1;
  int maxSteps = 1;
  // possible place of bugs with selectedCards logic
  List<PlayableCard> selectedCards = [];

  PlayableCard(
      {cardName = '',
      cardDescription = '',
      cardMana = 0,
      cardType = CardType.skill,
      cardTargetType = TargetEnum.singleTarget,
      cardSteps = 1,
      cardMaxSteps = 1,
      List<PlayableCard> cardSelectedCards = const [],
      cardEthereal = false,
      cardExhaused = false}) {
    ethereal = cardEthereal;
    exhausted = cardExhaused;
    name = cardName;
    description = cardDescription;
    mana = cardMana;
    step = cardSteps;
    maxSteps = cardMaxSteps;
    type = cardType;
    targetType = cardTargetType;
    selectedCards = cardSelectedCards;
  }

  String getCardName() {
    return name;
  }

  String getCardDescription() {
    return description;
  }

  bool getExhausted() {
    return exhausted;
  }

  int getMana() {
    return mana;
  }

  void setMana(int mana) {
    this.mana = mana;
  }

  List<PlayableCard> getSelectableCards() {
    // only for cards with targetEnum.cardTarget
    throw UnimplementedError();
  }

  void setSelectedCards(List<PlayableCard> selectedCards) {
    this.selectedCards = selectedCards;
  }

  int getMaxSelectableCards() {
    // only for cards with targetEnum.cardTarget
    throw UnimplementedError();
  }

  bool disposeToDiscard(
      List<PlayableCard> hand, List<PlayableCard> discardPile) {
    if (!ethereal) {
      discardPile.add(this);
    }
    hand.remove(this);
    return true;
  }

  bool isCardPlayable() => true;

  play(List<BaseCharacter> target) {
    // can be failed,
    // because of not correctly loaded from memory state or wrongly casted.
    // PlayableCard class in not used directly, only as Generic Type
    throw UnimplementedError();
  }

  factory PlayableCard.fromJson(dynamic json) {
    return PlayableCard(
        cardName: json['name'] as String,
        cardDescription: json['description'] as String,
        cardMana: json['mana'] as int,
        cardSteps: json['step'] as int,
        cardMaxSteps: json['maxSteps'] as int,
        cardExhaused: json['exhausted'] as bool,
        cardEthereal: json['ethereal'] as bool,
        cardType: decodeCardTypeFromJson(json['type']),
        cardTargetType: decodeTargetEnumFromJson(json['targetType']));
  }

  Map toJson() => {
        'name': name,
        'description': description,
        'mana': mana,
        'step': step,
        'maxSteps': maxSteps,
        'exhausted': exhausted,
        'ethereal': ethereal,
        'type': type.toString(),
        'targetType': targetType.toString(),
      };
}
