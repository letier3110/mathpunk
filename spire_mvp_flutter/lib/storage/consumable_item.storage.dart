import 'package:spire_mvp_flutter/classes/items/block.potion.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/items/fear.potion.dart';
import 'package:spire_mvp_flutter/classes/items/fruit_juice.potion.dart';

import '../classes/items/cunning.potion.dart';

ConsumableItem consumableItemFromJson(dynamic json) {
  String jsonRuntime = json['_runtime'] as String;

  ConsumableItem item;

  switch (jsonRuntime) {
    case 'BlockPotion':
      item = BlockPotion();
      break;
    case 'FearPotion':
      item = FearPotion();
      break;
    case 'FruitJuicePotion':
      item = FruitJuicePotion();
      break;
    case 'CunningPotion':
      item = CunningPotion();
      break;
    default:
      item = BlockPotion();
      break;
  }

  return item;
}

Map consumableItemToJson(ConsumableItem consumableItem) => {
      ...consumableItem.toJson(),
      '_runtime': consumableItem.runtimeType.toString()
    };