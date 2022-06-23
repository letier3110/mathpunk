import '../../interfaces/chest_room.interface.dart';
import '../enemy/enemy_goblin.dart';
import '../enemy/enemy.dart';
import '../reward.dart';
import 'room.dart';

class EnemyRoom extends Room implements IChestRoom {
  @override
  late bool isTreasureChestOpened;
  EnemyRoom(
      {required String roomId,
      List<Enemy>? roomEnemies,
      List<Reward>? roomRewards})
      : super(
            roomEnemies: roomEnemies ?? [EnemyGoblin()],
            roomRewards: roomRewards ?? [Reward()],
            roomId: roomId) {
    isTreasureChestOpened = false;
  }

  @override
  getShowTreasureChest() {
    return enemies.isEmpty;
  }

  @override
  getIsTreasureChestOpened() {
    return isTreasureChestOpened;
  }

  @override
  openTreasureChest() {
    if (getShowTreasureChest()) {
      isTreasureChestOpened = true;
    }
  }

  @override
  getCanLeaveRoom() {
    return getIsTreasureChestOpened();
  }
}
