import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/relic/relic.dart';
import 'package:spire_mvp_flutter/storage/consumable_item.storage.dart';
import 'package:spire_mvp_flutter/storage/playable_card.storage.dart';
import 'package:spire_mvp_flutter/storage/relic.storage.dart';

class Sellable {
  final int cost;
  // final int discount;
  bool inStock;
  Sellable({required this.cost, required this.inStock});

  int getCost() {
    return cost;
  }

  Widget getCostDescription() {
    return Text(getCost().toString());
  }

  factory Sellable.fromJson(dynamic json) {
    return Sellable(
        cost: json['cost'] as int, inStock: json['inStock'] as bool);
  }

  Map toJson() => {
        'cost': cost.toString(),
        'inStock': inStock.toString(),
      };
}

class SellableRemoval implements Sellable {
  @override
  final int cost;
  @override
  bool inStock;
  SellableRemoval({required this.cost, required this.inStock});

  @override
  int getCost() {
    return cost;
  }

  @override
  Widget getCostDescription() {
    return Text(
      getCost().toString(),
      style: const TextStyle(color: Colors.yellowAccent),
    );
  }

  @override
  Map toJson() => {
        'cost': cost.toString(),
        'inStock': inStock.toString(),
      };
}

class SellableCard implements Sellable {
  @override
  final int cost;
  @override
  bool inStock;
  final PlayableCard card;
  SellableCard({required this.card, required this.cost, required this.inStock});

  @override
  int getCost() {
    return cost;
  }

  @override
  Widget getCostDescription() {
    return Text(
      getCost().toString(),
      style: const TextStyle(color: Colors.yellowAccent),
    );
  }

  @override
  Map toJson() => {
        'cost': cost.toString(),
        'inStock': inStock.toString(),
        'card': playableCardToJson(card),
      };
}

class SellableRelic implements Sellable {
  @override
  final int cost;
  @override
  bool inStock;
  final Relic relic;
  SellableRelic(
      {required this.relic, required this.cost, required this.inStock});

  @override
  int getCost() {
    return cost;
  }

  @override
  Widget getCostDescription() {
    return Text(
      getCost().toString(),
      style: const TextStyle(color: Colors.yellowAccent),
    );
  }

  @override
  Map toJson() => {
        'cost': cost.toString(),
        'inStock': inStock.toString(),
        'relic': relicToJson(relic),
      };
}

class SellableItem implements Sellable {
  @override
  final int cost;
  @override
  bool inStock;
  final ConsumableItem item;
  SellableItem({required this.item, required this.cost, required this.inStock});

  @override
  int getCost() {
    return cost;
  }

  @override
  Widget getCostDescription() {
    return Text(
      getCost().toString(),
      style: const TextStyle(color: Colors.yellowAccent),
    );
  }

  @override
  Map toJson() => {
        'cost': cost.toString(),
        'inStock': inStock.toString(),
        'item': consumableItemToJson(item),
        '_runtime': 'SellableItem'
      };
}

Sellable sellableFromJson(dynamic json) {
  String jsonRuntime = json['_runtime'] as String;
  int jsonCost = json['cost'] as int;
  bool jsonInStock = json['inStock'] as bool;

  Sellable sellable;

  switch (jsonRuntime) {
    case 'SellableRemoval':
      sellable = SellableRemoval(cost: jsonCost, inStock: jsonInStock);
      break;
    case 'SellableCard':
      PlayableCard jsonCard = playableCardFromJson(json['card']);
      sellable =
          SellableCard(cost: jsonCost, inStock: jsonInStock, card: jsonCard);
      break;
    case 'SellableRelic':
      Relic jsonRelic = relicFromJson(json['relic']);
      sellable =
          SellableRelic(cost: jsonCost, inStock: jsonInStock, relic: jsonRelic);
      break;
    case 'SellableItem':
    default:
      ConsumableItem jsonItem = consumableItemFromJson(json['item']);
      sellable =
          SellableItem(cost: jsonCost, inStock: jsonInStock, item: jsonItem);
      break;
  }

  return sellable;
}

Map sellableToJson(Sellable sellable) =>
    {...sellable.toJson(), '_runtime': sellable.runtimeType.toString()};
