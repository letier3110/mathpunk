import 'package:spire_mvp_flutter/storage/playable_card.storage.dart';
import 'package:spire_mvp_flutter/storage/relic.storage.dart';

import 'relic/relic.dart';
import 'item.dart';
import 'card/playable_card.dart';

class Reward {
  Relic? relic;
  Item? item;
  List<PlayableCard> cards = const [];
  int? gold;

  // specify only one item of its object
  Reward(
      {Relic? rewardRelic,
      Item? rewardItem,
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
    Item? jsonItem = Item(); // TODOL to optional card
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
        'item': item,
        'cards': cards.map((e) => playableCardToJson(e)).toList(),
        'gold': gold,
      };
}
