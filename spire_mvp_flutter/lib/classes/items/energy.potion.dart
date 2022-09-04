import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

int energy = 2;

class EnergyPotion extends ConsumableItem {
  EnergyPotion()
      : super(
            itemName: 'Energy Potion',
            itemDescription: 'Gain 2 or 4 Energy.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription() {
    int localEnergy = energy;

    return 'Gain $localEnergy Energy.';
  }

  @override
  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localEnergy = energy;
    character.addMana(localEnergy);
  }
}
