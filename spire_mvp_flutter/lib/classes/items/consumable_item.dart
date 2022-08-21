import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

class ConsumableItem {
  late String name;
  late String description;
  late TargetEnum targetType = TargetEnum.singleTarget;
  List<PlayableCard> selectedCards = [];

  ConsumableItem(
      {itemName = '',
      itemDescription = '',
      itemTargetType = TargetEnum.singleTarget,
      List<PlayableCard> itemSelectedCards = const []}) {
    name = itemName;
    description = itemDescription;
    targetType = itemTargetType;
    selectedCards = itemSelectedCards;
  }

  String getItemName() {
    return name;
  }

  String getAssetImage() {
    // return 'assets/gray_potion.png';
    throw UnimplementedError();
  }

  String getItemDescription() {
    return description;
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

  play(List<BaseCharacter> target) {
    // can be failed,
    // because of not correctly loaded from memory state or wrongly casted.
    // PlayableCard class in not used directly, only as Generic Type
    throw UnimplementedError();
  }

  factory ConsumableItem.fromJson(dynamic json) {
    return ConsumableItem(
        itemName: json['name'] as String,
        itemDescription: json['description'] as String,
        itemTargetType: decodeTargetEnumFromJson(json['targetType']));
  }

  Map toJson() => {
        'name': name,
        'description': description,
        'targetType': targetType.toString(),
      };
}
