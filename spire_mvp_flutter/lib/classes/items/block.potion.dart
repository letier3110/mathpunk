import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../player/player_character/player_character.dart';

int block = 12;

class BlockPotion extends ConsumableItem {
  BlockPotion()
      : super(
            itemName: 'Block Potion',
            itemDescription:
                'Gain 12 (SacredBark.png 24) Icon Block.png Block.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription() {
    int localBlock = block;

    return 'Gain $localBlock Block.';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localBlock = block;
    character.addBlock(localBlock);
  }
}
