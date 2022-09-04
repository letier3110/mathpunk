import 'package:mathpunk_cardgame/storage/enemy.storage.dart';

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
  late List<Room> nextRooms = [];

  Room(
      {required String roomId,
      required List<Enemy> roomEnemies,
      required List<Reward> roomRewards,
      List<Room>? roomNexts})
      : super() {
    id = roomId;
    enemies = roomEnemies;
    rewards = roomRewards;
    if (roomNexts != null) {
      nextRooms = roomNexts;
    }
  }

  void setId(String id) {
    this.id = id;
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
    // can be failed,
    // because of not correctly loaded from memory state or wrongly casted.
    // PlayableCard class in not used directly, only as Generic Type
    throw UnimplementedError();
  }

  factory Room.fromJson(dynamic json) {
    String jsonId = json['id'] as String;
    List<Enemy> jsonEnemies =
        (json['enemies'] as List).map((e) => enemyFromJson(e)).toList();
    List<Reward> jsonRewards =
        (json['rewards'] as List).map((e) => Reward.fromJson(e)).toList();
    Room jsonRoom = Room(
        roomId: jsonId, roomEnemies: jsonEnemies, roomRewards: jsonRewards);

    return jsonRoom;
  }

  Map toJson() => {
        'enemies': enemies.map((e) => enemyToJson(e)).toList(),
        'rewards': rewards.map((e) => e.toJson()).toList(),
        'nextRooms':
            nextRooms.isEmpty ? [] : nextRooms.map((e) => e.toJson()).toList(),
        'id': id,
      };
}
