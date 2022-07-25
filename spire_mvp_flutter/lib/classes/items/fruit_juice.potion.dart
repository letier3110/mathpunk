import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

int maxHp = 10;

class FruitJuicePotion extends ConsumableItem {
  FruitJuicePotion()
      : super(
            itemName: 'Fruit Juice',
            itemDescription: 'Gain 5 (SacredBark.png 10) Max HP.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription() {
    int localMaxHp = maxHp;

    return 'Gain $localMaxHp Max HP.';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localMaxHp = maxHp;
    character.setMaxHealth(character.maxHealth + localMaxHp);
  }
}
