import '../classes/enemy/enemy.dart';
import '../classes/reward.dart';

class IRoom {
  late String id;
  late List<Enemy> enemies;
  late List<Reward> rewards;

  bool getCanLeaveRoom() {
    return true;
  }
}
