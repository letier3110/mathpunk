import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

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
  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localBlock = block;

    BlockStatus bs = BlockStatus();
    bs.addStack(localBlock.toDouble());
    character.addStatus(bs);
  }
}
