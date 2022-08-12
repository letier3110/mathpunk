import 'dart:math';

import 'package:spire_mvp_flutter/classes/enemy/enemy_ogre.dart';
import 'package:spire_mvp_flutter/classes/reward.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/pools/reward.pools.dart';
import 'package:spire_mvp_flutter/pools/trader.pools.dart';
import 'package:spire_mvp_flutter/utils/room.util.dart';

const int _levelsRandomLength = 7;
const int _levelsFixedLength = 12;
const int _roomsCountPerSliceRandom = 3;
const int _roomsCountPerSliceFixed = 2;
const int _nextRoomsConnectionsRandom = 1;
const int _nextRoomsConnectionsFixed = 1;
const int _roomConnectionProbability = 50;
const int _tradeRoomProbability = 10;

List<List<Room>> generateMap() {
  List<List<Room>> gameMap = [];
  var rng = Random();
  var maxLevels = rng.nextInt(_levelsRandomLength) + _levelsFixedLength;
  List<Room> prevSlice = [];
  for (var i = 0; i < maxLevels; i++) {
    var roomsCount =
        rng.nextInt(_roomsCountPerSliceRandom) + _roomsCountPerSliceFixed;
    List<Room> roomSlice = [];
    for (var j = 0; j < roomsCount; j++) {
      Level1RewardPool pool = Level1RewardPool();
      Room room = EnemyRoom(roomId: '$j $i', roomRewards: [
        Reward(
            rewardCards: pool.getCards(),
            rewardItem: pool.getItems(),
            rewardRelic: pool.getRelics(),
            rewardGold: rng.nextInt(100) + 50)
      ]);
      if (getProbability(_tradeRoomProbability) || i == 0) {
        Level1TraderPool pool = Level1TraderPool();
        room = TradeRoom(
            roomId: 'trade$j $i',
            cards: pool.getCards(),
            relics: pool.getRelics(),
            items: pool.getItems());
      }
      roomSlice.add(room);
    }
    if (prevSlice.isNotEmpty) {
      for (var room in prevSlice) {
        var roomConnections = 0;
        var maxRoomConnetions = rng.nextInt(_nextRoomsConnectionsRandom) +
            _nextRoomsConnectionsFixed;
        for (var j = 0; j < roomsCount; j++) {
          if (roomConnections == maxRoomConnetions) continue;
          if (getProbability(_roomConnectionProbability)) {
            room.nextRooms.add(roomSlice[j]);
            roomConnections++;
          }
        }
      }
    }
    prevSlice = roomSlice;
    gameMap.add(roomSlice);
  }
  Level1RewardBossPool pool = Level1RewardBossPool();
  var bossRoom = EnemyRoom(roomId: 'boss1', roomRewards: [
    Reward(
        rewardCards: pool.getRelics(),
        rewardRelic: pool.getRelics(),
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
