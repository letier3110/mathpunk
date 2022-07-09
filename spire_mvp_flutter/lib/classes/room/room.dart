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

  factory Room.fromJson(dynamic json) {
    String jsonId = json['id'] as String;
    List<Enemy> jsonEnemies =
        (json['enemies'] as List).map((e) => Enemy.fromJson(e)).toList();
    List<Reward> jsonRewards =
        (json['rewards'] as List).map((e) => Reward.fromJson(e)).toList();
    Room jsonRoom = Room(
        roomId: jsonId, roomEnemies: jsonEnemies, roomRewards: jsonRewards);

    return jsonRoom;
  }

  Map toJson() => {
        'enemies': enemies,
        'rewards': rewards,
        'id': id,
      };
}
