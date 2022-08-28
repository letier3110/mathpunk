import 'package:spire_mvp_flutter/interfaces/chest_room.interface.dart';

import '../enemy/enemy.dart';
import '../reward.dart';
import 'room.dart';

class TreasureRoom extends Room implements IChestRoom {
  @override
  late bool isTreasureChestOpened;

  TreasureRoom(
      {required String roomId,
      List<Enemy>? roomEnemies,
      List<Reward>? roomRewards})
      : super(roomEnemies: [], roomRewards: [Reward()], roomId: roomId) {
    isTreasureChestOpened = false;
  }

  @override
  getShowTreasureChest() {
    return true;
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
