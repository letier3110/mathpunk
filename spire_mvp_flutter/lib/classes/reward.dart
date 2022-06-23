import 'relic.dart';
import 'item.dart';
import 'card/card.dart';

// type Reward = Relic | Item | Card | number;

// actualy its Relic|Item|Card|number|null now, due to Dart
class Reward {
  late Relic? relic;
  late Item? item;
  late Card? card;
  late int? gold;

  // specify only one item of its object
  Reward(
      {Relic? rewardRelic,
      Item? rewardItem,
      Card? rewardCard,
      int? rewardGold}) {
    relic = rewardRelic;
    item = rewardItem;
    card = rewardCard;
    gold = rewardGold;
  }

  getValue() {
    return relic ?? item ?? card ?? gold;
  }
}
