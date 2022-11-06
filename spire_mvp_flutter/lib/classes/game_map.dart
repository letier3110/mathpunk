import 'dart:math';

import 'package:mathpunk_cardgame/classes/enemy/enemy_ogre.dart';
import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/classes/room/trade_room.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/pools/events.pools.dart';
import 'package:mathpunk_cardgame/pools/reward.pools.dart';
import 'package:mathpunk_cardgame/pools/trader.pools.dart';

const int _levelsRandomLength = 7;
const int _levelsFixedLength = 12;
const int _roomsCountPerSliceRandom = 3;
const int _roomsCountPerSliceFixed = 3;
const int _tradeRoomProbability = 10;
const int _eventRoomProbability = 5;

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
      Level1RewardPool rewardPool = Level1RewardPool();
      Room room = EnemyRoom(roomId: '$j $i', roomRewards: [
        Reward(
            rewardCards: rewardPool.getCards(),
            rewardItem: rewardPool.getItems(),
            rewardRelic: rewardPool.getRelics(),
            rewardGold: rng.nextInt(100) + 50)
      ]);
      if (getProbability(_eventRoomProbability)) {
        Level1EventRoomPool pool = Level1EventRoomPool();
        room = pool.getEventRoom();
        String id = 'event$j $i';
        room.setId(id);
        // room.id = 'event$j $i';
      } else if (getProbability(_tradeRoomProbability)) {
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
      var roomSliceCopy = roomSlice.map((x) => x).toList();
      var maxCount = roomSliceCopy.length / prevSlice.length;
      for (var baseCount = 0; baseCount < maxCount.ceil(); baseCount++) {
        for (var room in prevSlice) {
          if (roomSliceCopy.isEmpty) {
            roomSliceCopy = roomSlice.map((x) => x).toList();
          }
          var randChoice = rng.nextInt(roomSliceCopy.length);
          room.nextRooms.add(roomSliceCopy[randChoice]);
          roomSliceCopy.removeAt(randChoice);
        }
      }
    }
    prevSlice = roomSlice;
    gameMap.add(roomSlice);
  }
  var bossRoom = generateBossRoom();
  for (var i = 0; i < gameMap.last.length; i++) {
    gameMap.last[i].nextRooms = [bossRoom];
  }
  gameMap.add([bossRoom]);

  return gameMap;
}

Room generateBossRoom({Room? room}) {
  var rng = Random();
  Level1RewardBossPool pool = Level1RewardBossPool();
  var bossRoom = EnemyRoom(
    roomId: 'boss1',
    roomRewards: [
      Reward(
          rewardCards: pool.getCards(),
          rewardRelic: pool.getRelics(),
          rewardGold: rng.nextInt(100) + 50)
    ],
    roomEnemies: [EnemyOgre()],
  );
  if (room != null) {
    bossRoom.nextRooms = room.nextRooms;
  }
  return bossRoom;
}
