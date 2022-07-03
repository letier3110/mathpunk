import '../../interfaces/room.interface.dart';
import '../enemy/enemy.dart';
import '../reward.dart';

class Room implements IRoom {
  @override
  late List<Enemy> enemies;
  @override
  late List<Reward> rewards;
  @override
  late String id;

  Room(
      {required String roomId,
      required List<Enemy> roomEnemies,
      required List<Reward> roomRewards})
      : super() {
    id = roomId;
    enemies = roomEnemies;
    rewards = roomRewards;
  }

  attachEnemies(List<Enemy> newEnemies) {
    enemies = newEnemies;
  }

  attachRewards(List<Reward> newRewards) {
    rewards = newRewards;
  }

  List<Enemy> getEnemies() {
    return enemies;
  }

  getRewards() {
    return rewards;
  }

  static isEqual(Room a, Room b) {
    return a.id == b.id;
  }

  @override
  bool getCanLeaveRoom() {
    return true;
  }
}
