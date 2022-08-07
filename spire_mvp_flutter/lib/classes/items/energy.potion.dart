import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

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
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localEnergy = energy;
    character.addMana(localEnergy);
  }
}
