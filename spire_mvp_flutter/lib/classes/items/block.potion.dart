import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../player/player_character/player_character.dart';

class BlockPotion extends ConsumableItem {
  int block = 12;
  BlockPotion()
      : super(
            itemName: 'Block Potion',
            itemDescription:
                'Gain 12 (SacredBark.png 24) Icon Block.png Block.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription(BuildContext context) {
    int localBlock = block;

    return AppLocalizations.of(context)!
        .applyBlockEffectDescription(localBlock.toString());
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
