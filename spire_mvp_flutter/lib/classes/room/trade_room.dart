import '../enemy/enemy.dart';
import '../reward.dart';
import 'room.dart';

class TradeRoom extends Room {
  TradeRoom(
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
