import 'dart:math';

import 'package:spire_mvp_flutter/classes/card/anger.card.dart';
import 'package:spire_mvp_flutter/classes/card/bash.card.dart';
import 'package:spire_mvp_flutter/classes/card/perfect_strike.card.dart';
import 'package:spire_mvp_flutter/classes/card/shiv.card.dart';
import 'package:spire_mvp_flutter/classes/card/shrug_it_off.card.dart';
import 'package:spire_mvp_flutter/classes/card/strike.card.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy_ogre.dart';
import 'package:spire_mvp_flutter/classes/items/block.potion.dart';
import 'package:spire_mvp_flutter/classes/items/energy.potion.dart';
import 'package:spire_mvp_flutter/classes/items/fear.potion.dart';
import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_serpent.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_snake.relic.dart';
import 'package:spire_mvp_flutter/classes/reward.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/classes/sellable.dart';
import 'package:spire_mvp_flutter/utils/room.util.dart';

const int levelsRandomLength = 7;
const int levelsFixedLength = 12;
const int roomsCountPerSliceRandom = 3;
const int roomsCountPerSliceFixed = 2;
const int nextRoomsConnectionsRandom = 1;
const int nextRoomsConnectionsFixed = 1;
const int roomConnectionProbability = 50;
const int tradeRoomProbability = 10;

const int traderCardCostRandom = 125;
const int traderCardCostFixed = 25;
const int traderCardCostSaleProbability = 12;

const int traderRelicCostRandom = 225;
const int traderRelicCostFixed = 125;
const int traderRelicCostSaleProbability = 5;

const int traderItemCostRandom = 150;
const int traderItemCostFixed = 50;
const int traderItemCostSaleProbability = 5;

List<List<Room>> generateMap() {
  List<List<Room>> gameMap = [];
  var rng = Random();
  var maxLevels = rng.nextInt(levelsRandomLength) + levelsFixedLength;
  List<Room> prevSlice = [];
  for (var i = 0; i < maxLevels; i++) {
    var roomsCount =
        rng.nextInt(roomsCountPerSliceRandom) + roomsCountPerSliceFixed;
    List<Room> roomSlice = [];
    for (var j = 0; j < roomsCount; j++) {
      Room room = EnemyRoom(roomId: '$j $i', roomRewards: [
        Reward(
            rewardCards: [AngerCard(), StrikeCard(), BashCard()],
            rewardItem: FearPotion(),
            rewardRelic: BurningBloodRelic(),
            rewardGold: rng.nextInt(100) + 50)
      ]);
      if (getProbability(tradeRoomProbability) || i == 0) {
        room = TradeRoom(roomId: 'trade$j $i', cards: [
          SellableCard(
              card: AngerCard(),
              cost: rng.nextInt(traderCardCostRandom) + traderCardCostFixed,
              inStock: true),
          SellableCard(
              card: StrikeCard(),
              cost: rng.nextInt(traderCardCostRandom) + traderCardCostFixed,
              inStock: true),
          SellableCard(
              card: BashCard(),
              cost: rng.nextInt(traderCardCostRandom) + traderCardCostFixed,
              inStock: true),
          SellableCard(
              card: ShivCard(),
              cost: rng.nextInt(traderCardCostRandom) + traderCardCostFixed,
              inStock: true),
          SellableCard(
              card: ShrugItOffCard(),
              cost: rng.nextInt(traderCardCostRandom) + traderCardCostFixed,
              inStock: true),
          SellableCard(
              card: ShrugItOffCard(),
              cost: rng.nextInt(traderCardCostRandom) + traderCardCostFixed,
              inStock: true),
          SellableCard(
              card: PerfectStrikeCard(),
              cost: rng.nextInt(traderCardCostRandom) + traderCardCostFixed,
              inStock: true)
        ], relics: [
          SellableRelic(
              relic: BurningBloodRelic(),
              cost: rng.nextInt(traderRelicCostRandom) + traderRelicCostFixed,
              inStock: true),
          SellableRelic(
              relic: RingOfSerpent(),
              cost: rng.nextInt(traderRelicCostRandom) + traderRelicCostFixed,
              inStock: true),
          SellableRelic(
              relic: RingOfSnake(),
              cost: rng.nextInt(traderRelicCostRandom) + traderRelicCostFixed,
              inStock: true)
        ], items: [
          SellableItem(
              item: FearPotion(),
              cost: rng.nextInt(traderItemCostRandom) + traderItemCostFixed,
              inStock: true),
          SellableItem(
              item: BlockPotion(),
              cost: rng.nextInt(traderItemCostRandom) + traderItemCostFixed,
              inStock: true),
          SellableItem(
              item: EnergyPotion(),
              cost: rng.nextInt(traderItemCostRandom) + traderItemCostFixed,
              inStock: true)
        ]);
      }
      roomSlice.add(room);
    }
    if (prevSlice.isNotEmpty) {
      for (var room in prevSlice) {
        var roomConnections = 0;
        var maxRoomConnetions =
            rng.nextInt(nextRoomsConnectionsRandom) + nextRoomsConnectionsFixed;
        for (var j = 0; j < roomsCount; j++) {
          if (roomConnections == maxRoomConnetions) continue;
          if (getProbability(roomConnectionProbability)) {
            room.nextRooms.add(roomSlice[j]);
            roomConnections++;
          }
        }
      }
    }
    prevSlice = roomSlice;
    gameMap.add(roomSlice);
  }
  var bossRoom = EnemyRoom(roomId: 'boss1', roomRewards: [
    Reward(
        rewardCards: [AngerCard(), StrikeCard(), BashCard()],
        rewardRelic: BurningBloodRelic(),
        rewardGold: rng.nextInt(100) + 50)
  ], roomEnemies: [
    EnemyOgre()
  ]);
  for (var i = 0; i < gameMap.last.length; i++) {
    gameMap.last[i].nextRooms = [bossRoom];
  }
  gameMap.add([bossRoom]);

  return gameMap;
}
