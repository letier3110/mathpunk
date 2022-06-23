class IChestRoom {
  late bool isTreasureChestOpened;

  bool getShowTreasureChest() {
    return true;
  }

  bool getIsTreasureChestOpened() {
    return isTreasureChestOpened;
  }

  void openTreasureChest() {
    if (getShowTreasureChest()) {
      isTreasureChestOpened = true;
    }
  }
}
