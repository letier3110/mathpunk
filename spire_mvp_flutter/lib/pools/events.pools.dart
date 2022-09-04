import 'package:mathpunk_cardgame/classes/probability.dart';
import 'package:mathpunk_cardgame/classes/room/event_room/event_room.dart';
import 'package:mathpunk_cardgame/classes/room/event_room/mind_bloom.event.dart';
import 'package:mathpunk_cardgame/pools/utils.dart';
import 'package:mathpunk_cardgame/storage/room.storage.dart';

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
