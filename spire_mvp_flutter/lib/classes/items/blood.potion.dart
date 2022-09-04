import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

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
