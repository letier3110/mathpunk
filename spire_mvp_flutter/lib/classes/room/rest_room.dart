import '../enemy/enemy.dart';
import '../reward.dart';
import 'room.dart';

class RestRoom extends Room {
  RestRoom(
      {required String roomId,
      List<Enemy>? roomEnemies,
      List<Reward>? roomRewards})
      : super(
            roomEnemies: roomEnemies = [],
            roomRewards: roomRewards = [],
            roomId: roomId);

  @override
  bool getCanLeaveRoom() {
    return true;
  }
}
