import 'package:mathpunk_cardgame/storage/consumable_item.storage.dart';
import 'package:mathpunk_cardgame/storage/playable_card.storage.dart';
import 'package:mathpunk_cardgame/storage/relic.storage.dart';

import 'relic/relic.dart';
import 'items/consumable_item.dart';
import 'card/playable_card.dart';

class Reward {
  Relic? relic;
  ConsumableItem? item;
  List<PlayableCard> cards = const [];
  int? gold;

  // specify only one item of its object
  Reward(
      {Relic? rewardRelic,
      ConsumableItem? rewardItem,
      List<PlayableCard> rewardCards = const [],
      int? rewardGold}) {
    relic = rewardRelic;
    item = rewardItem;
    cards = rewardCards;
    gold = rewardGold;
  }

  factory Reward.fromJson(dynamic json) {
    Relic? jsonRelic =
        json['relic'] == null ? null : relicFromJson(json['relic']);
    ConsumableItem? jsonItem =
        json['item'] == null ? null : consumableItemFromJson(json['item']);
    List<PlayableCard> jsonCards =
        (json['cards'] as List).map((e) => playableCardFromJson(e)).toList();
    int? jsonGold = json['gold'] as int?;

    Reward jsonReward = Reward(
        rewardRelic: jsonRelic,
        rewardItem: jsonItem,
        rewardCards: jsonCards,
        rewardGold: jsonGold);

    return jsonReward;
  }

  Map toJson() => {
        'relic': relic != null ? relicToJson(relic!) : null,
        'item': item != null ? consumableItemToJson(item!) : null,
        'cards': cards.map((e) => playableCardToJson(e)).toList(),
        'gold': gold,
      };
}
