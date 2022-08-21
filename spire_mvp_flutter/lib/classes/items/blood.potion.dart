import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

double healAmount = 0.2;

class BloodPotion extends ConsumableItem {
  BloodPotion()
      : super(
            itemName: 'Blood Potion',
            itemDescription: 'Heal for 20% of your Max HP.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription() {
    int localHealAmount = (healAmount * 100).floor();

    return 'Heal for $localHealAmount% of your Max HP.';
  }

  @override
  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    double localHealAmount = healAmount;
    character.heal((character.maxHealth * localHealAmount).floor());
  }
}
