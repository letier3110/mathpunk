import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

int vulnerable = 3;

class FearPotion extends ConsumableItem {
  FearPotion()
      : super(
            itemName: 'Fear Potion',
            itemDescription:
                'Apply 3 (SacredBark.png 6) Icon Vulnerable.png Vulnerable.',
            itemTargetType: TargetEnum.singleTarget);

  @override
  String getItemDescription() {
    int localVulnerable = vulnerable;

    return 'Apply $localVulnerable Vulnerable.';
  }

  @override
  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      int localVulnerable = vulnerable;
      target[0].addVulnerable(localVulnerable);
    }
  }
}
