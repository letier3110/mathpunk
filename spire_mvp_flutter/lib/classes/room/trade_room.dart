import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/relic/relic.dart';
import 'package:spire_mvp_flutter/storage/consumable_item.storage.dart';
import 'package:spire_mvp_flutter/storage/playable_card.storage.dart';
import 'package:spire_mvp_flutter/storage/relic.storage.dart';

import '../../storage/enemy.storage.dart';
import 'room.dart';

class TradeRoom extends Room {
  bool visitedTrader = false;
  List<PlayableCard> cards;
  List<Relic> relics;
  List<ConsumableItem> items;

  TradeRoom(
      {required String roomId, // rewards is items, that possesed by trader
      required this.cards,
      required this.relics,
      required this.items})
      : super(roomEnemies: [], roomRewards: [], roomId: roomId);

  @override
  bool getCanLeaveRoom() {
    return visitedTrader;
  }

  factory TradeRoom.fromJson(dynamic json) {
    String jsonId = json['id'] as String;
    List<PlayableCard> jsonCards =
        (json['cards'] as List).map((e) => playableCardFromJson(e)).toList();
    List<Relic> jsonRelics =
        (json['relics'] as List).map((e) => relicFromJson(e)).toList();
    List<ConsumableItem> jsonItems =
        (json['items'] as List).map((e) => consumableItemFromJson(e)).toList();
    TradeRoom jsonRoom = TradeRoom(
        roomId: jsonId, cards: jsonCards, relics: jsonRelics, items: jsonItems);

    return jsonRoom;
  }

  @override
  Map toJson() => {
        'enemies': enemies.map((e) => enemyToJson(e)).toList(),
        'rewards': rewards.map((e) => e.toJson()).toList(),
        'relics': relics.map((e) => relicToJson(e)).toList(),
        'items': items.map((e) => consumableItemToJson(e)).toList(),
        'cards': cards.map((e) => playableCardToJson(e)).toList(),
        'nextRooms':
            nextRooms.isEmpty ? [] : nextRooms.map((e) => e.toJson()).toList(),
        'id': id,
      };
}
