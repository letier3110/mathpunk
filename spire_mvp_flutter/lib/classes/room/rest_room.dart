import '../enemy/enemy.dart';
import '../reward.dart';
import 'room.dart';

class RestRoom extends Room {
  RestRoom(
      {required String roomId,
      required List<Enemy> roomEnemies,
      required List<Reward> roomRewards})
      : super(
            roomEnemies: roomEnemies, roomRewards: roomRewards, roomId: roomId);
}
