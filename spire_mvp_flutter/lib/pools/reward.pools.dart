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
import 'package:mathpunk_cardgame/pools/utils.dart';
import 'package:mathpunk_cardgame/storage/consumable_item.storage.dart';
import 'package:mathpunk_cardgame/storage/playable_card.storage.dart';
import 'package:mathpunk_cardgame/storage/relic.storage.dart';

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

class Level1RewardPool {
  Level1RewardPool();

  getCards() {
    return List.generate(
        3,
        (index) => playableCardFromJson(
            playableCardToJson(weightedRandomPick(_pool1Cards).obj)));
  }

  getRelics() {
    return relicFromJson(relicToJson(weightedRandomPick(_pool1Relics).obj));
  }

  getItems() {
    return consumableItemFromJson(
        consumableItemToJson(weightedRandomPick(_pool1Items).obj));
  }
}

class Level1RewardBossPool {
  Level1RewardBossPool();

  getCards() {
    return List.generate(
        3,
        (index) => playableCardFromJson(
            playableCardToJson(weightedRandomPick(_pool1Cards).obj)));
  }

  getRelics() {
    return relicFromJson(relicToJson(weightedRandomPick(_pool1Relics).obj));
  }

  getItems() {
    return consumableItemFromJson(
        consumableItemToJson(weightedRandomPick(_pool1Items).obj));
  }
}
