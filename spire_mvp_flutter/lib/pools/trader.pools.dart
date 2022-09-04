import 'dart:math';

import 'package:mathpunk_cardgame/classes/card/anger.card.dart';
import 'package:mathpunk_cardgame/classes/card/bash.card.dart';
import 'package:mathpunk_cardgame/classes/card/perfect_strike.card.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/card/shrug_it_off.card.dart';
import 'package:mathpunk_cardgame/classes/card/strike.card.dart';
import 'package:mathpunk_cardgame/classes/items/block.potion.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/items/energy.potion.dart';
import 'package:mathpunk_cardgame/classes/items/fear.potion.dart';
import 'package:mathpunk_cardgame/classes/probability.dart';
import 'package:mathpunk_cardgame/classes/relic/burning_blood.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_serpent.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_snake.relic.dart';
import 'package:mathpunk_cardgame/classes/sellable.dart';
import 'package:mathpunk_cardgame/pools/utils.dart';
import 'package:mathpunk_cardgame/storage/consumable_item.storage.dart';
import 'package:mathpunk_cardgame/storage/playable_card.storage.dart';
import 'package:mathpunk_cardgame/storage/relic.storage.dart';

const int _traderCardCostRandom = 125;
const int _traderCardCostFixed = 25;
// const int traderCardCostSaleProbability = 12;

const int _traderRelicCostRandom = 225;
const int _traderRelicCostFixed = 125;
// const int traderRelicCostSaleProbability = 5;

const int _traderItemCostRandom = 150;
const int _traderItemCostFixed = 50;
// const int traderItemCostSaleProbability = 5;

List<Probability<PlayableCard>> _pool1Cards = [
  Probability(obj: AngerCard(), weight: 500),
  Probability(obj: StrikeCard(), weight: 200),
  Probability(obj: BashCard(), weight: 200),
  Probability(obj: ShivCard(), weight: 200),
  Probability(obj: ShrugItOffCard(), weight: 200),
  Probability(obj: PerfectStrikeCard(), weight: 200)
];

List<Probability<Relic>> _pool1Relics = [
  Probability(obj: BurningBloodRelic(), weight: 500),
  Probability(obj: RingOfSerpent(), weight: 200),
  Probability(obj: RingOfSnake(), weight: 200)
];

List<Probability<ConsumableItem>> _pool1Items = [
  Probability(obj: FearPotion(), weight: 500),
  Probability(obj: BlockPotion(), weight: 200),
  Probability(obj: EnergyPotion(), weight: 50)
];

class Level1TraderPool {
  Level1TraderPool();

  getCards() {
    var rng = Random();
    return List.generate(
        7,
        (index) => SellableCard(
            card: playableCardFromJson(
                playableCardToJson(weightedRandomPick(_pool1Cards).obj)),
            cost: rng.nextInt(_traderCardCostRandom) + _traderCardCostFixed,
            inStock: true));
  }

  getRelics() {
    var rng = Random();
    return List.generate(
        3,
        (index) => SellableRelic(
            relic: relicFromJson(
                relicToJson(weightedRandomPick(_pool1Relics).obj)),
            cost: rng.nextInt(_traderRelicCostRandom) + _traderRelicCostFixed,
            inStock: true));
  }

  getItems() {
    var rng = Random();
    return List.generate(
        3,
        (index) => SellableItem(
            item: consumableItemFromJson(
                consumableItemToJson(weightedRandomPick(_pool1Items).obj)),
            cost: rng.nextInt(_traderItemCostRandom) + _traderItemCostFixed,
            inStock: true));
  }
}
