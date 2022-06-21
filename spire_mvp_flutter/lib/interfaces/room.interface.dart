import '../classes/enemy.dart';
import '../classes/reward.dart';

typedef GetCanLeaveRoom = bool Function();

class IRoom {
  late String id;
  late List<Enemy> enemies;
  late List<Reward> rewards;

  bool getCanLeaveRoom() {
    return true;
  }
}
