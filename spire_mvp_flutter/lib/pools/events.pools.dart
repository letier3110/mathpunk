import 'package:spire_mvp_flutter/classes/probability.dart';
import 'package:spire_mvp_flutter/classes/room/event_room/event_room.dart';
import 'package:spire_mvp_flutter/classes/room/event_room/mind_bloom.event.dart';
import 'package:spire_mvp_flutter/pools/utils.dart';
import 'package:spire_mvp_flutter/storage/room.storage.dart';

List<Probability<EventRoom>> _pool1EventRooms = [
  Probability(obj: MindBloomEventRoom(), weight: 500)
];

class Level1EventRoomPool {
  Level1EventRoomPool();

  EventRoom getEventRoom() {
    return roomFromJson(roomToJson(weightedRandomPick(_pool1EventRooms).obj))
        as EventRoom;
  }
}
