import 'package:spire_mvp_flutter/classes/sellable.dart';
import 'package:spire_mvp_flutter/storage/consumable_item.storage.dart';
import 'package:spire_mvp_flutter/storage/playable_card.storage.dart';
import 'package:spire_mvp_flutter/storage/relic.storage.dart';

import '../../storage/enemy.storage.dart';
import 'room.dart';

class TradeRoom extends Room {
  bool visitedTrader = false;
  List<SellableCard> cards;
  List<SellableRelic> relics;
  List<SellableItem> items;
  late SellableRemoval removal;

  TradeRoom(
      {required String roomId,
      required this.cards,
      required this.relics,
      required this.items,
      SellableRemoval? removal})
      : super(roomEnemies: [], roomRewards: [], roomId: roomId) {
    this.removal = removal ?? SellableRemoval(cost: 75, inStock: true);
  }

  @override
  bool getCanLeaveRoom() {
    return visitedTrader;
  }

  factory TradeRoom.fromJson(dynamic json) {
    String jsonId = json['id'] as String;
    List<SellableCard> jsonCards = (json['cards'] as List)
        .map((e) => sellableFromJson(e) as SellableCard)
        .toList();
    List<SellableRelic> jsonRelics = (json['relics'] as List)
        .map((e) => sellableFromJson(e) as SellableRelic)
        .toList();
    List<SellableItem> jsonItems = (json['items'] as List)
        .map((e) => sellableFromJson(e) as SellableItem)
        .toList();
    SellableRemoval jsonRemoval =
        sellableFromJson(json['removal']) as SellableRemoval;
    TradeRoom jsonRoom = TradeRoom(
        roomId: jsonId,
        cards: jsonCards,
        relics: jsonRelics,
        items: jsonItems,
        removal: jsonRemoval);

    return jsonRoom;
  }

  @override
  Map toJson() => {
        'enemies': enemies.map((e) => enemyToJson(e)).toList(),
        'rewards': rewards.map((e) => e.toJson()).toList(),
        'relics': relics.map((e) => sellableToJson(e)).toList(),
        'items': items.map((e) => sellableToJson(e)).toList(),
        'cards': cards.map((e) => sellableToJson(e)).toList(),
        'removal': sellableToJson(removal),
        'nextRooms':
            nextRooms.isEmpty ? [] : nextRooms.map((e) => e.toJson()).toList(),
        'id': id,
      };
}
