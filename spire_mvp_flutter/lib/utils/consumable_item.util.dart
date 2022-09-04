import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';

String getItemAssetByName(ConsumableItem? item) {
  switch (item?.name) {
    case 'Cunning Potion':
      return 'assets/gray_potion.png';
    case 'EnergyPotion':
      return 'assets/orange_potion.png';
    case 'FearPotion':
      return 'assets/orange_potion.png';
    case 'Enigma':
      return 'assets/orange_potion.png';
    default:
      return 'assets/barbarian.png';
  }
}
