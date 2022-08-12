import 'dart:math';

import 'package:spire_mvp_flutter/classes/card/anger.card.dart';
import 'package:spire_mvp_flutter/classes/card/bash.card.dart';
import 'package:spire_mvp_flutter/classes/card/perfect_strike.card.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/card/shiv.card.dart';
import 'package:spire_mvp_flutter/classes/card/shrug_it_off.card.dart';
import 'package:spire_mvp_flutter/classes/card/strike.card.dart';
import 'package:spire_mvp_flutter/classes/items/block.potion.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/items/energy.potion.dart';
import 'package:spire_mvp_flutter/classes/items/fear.potion.dart';
import 'package:spire_mvp_flutter/classes/probability.dart';
import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_serpent.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_snake.relic.dart';
import 'package:spire_mvp_flutter/classes/sellable.dart';
import 'package:spire_mvp_flutter/pools/utils.dart';

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
            card: weightedRandomPick(_pool1Cards).obj,
            cost: rng.nextInt(_traderCardCostRandom) + _traderCardCostFixed,
            inStock: true));
  }

  getRelics() {
    var rng = Random();
    return List.generate(
        3,
        (index) => SellableRelic(
            relic: weightedRandomPick(_pool1Relics).obj,
            cost: rng.nextInt(_traderRelicCostRandom) + _traderRelicCostFixed,
            inStock: true));
  }

  getItems() {
    var rng = Random();
    return List.generate(
        7,
        (index) => SellableItem(
            item: weightedRandomPick(_pool1Items).obj,
            cost: rng.nextInt(_traderItemCostRandom) + _traderItemCostFixed,
            inStock: true));
  }
}
