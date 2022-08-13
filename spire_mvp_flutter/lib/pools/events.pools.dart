import 'dart:math';

import 'package:spire_mvp_flutter/classes/probability.dart';
import 'package:spire_mvp_flutter/classes/room/event_room/event_room.dart';
import 'package:spire_mvp_flutter/classes/room/event_room/mind_bloom.event.dart';
import 'package:spire_mvp_flutter/pools/utils.dart';

List<Probability<EventRoom>> _pool1EventRooms = [
  Probability(obj: MindBloomEventRoom(), weight: 500)
];

class Level1EventRoomPool {
  Level1EventRoomPool();

  getEventRoom() {
    return weightedRandomPick(_pool1EventRooms).obj;
  }
}
