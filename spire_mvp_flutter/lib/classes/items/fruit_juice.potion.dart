import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class FruitJuicePotion extends ConsumableItem {
  int maxHp = 10;
  FruitJuicePotion()
      : super(
            itemName: 'Fruit Juice',
            itemDescription: 'Gain 5 (SacredBark.png 10) Max HP.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemName(BuildContext context) =>
      AppLocalizations.of(context)!.fruitJuicePotionName;

  @override
  String getItemDescription(BuildContext context) {
    int localMaxHp = maxHp;

    String result = AppLocalizations.of(context)!
        .applyMaxHpEffectDescription(localMaxHp.toString());

    return result;
  }

  @override
  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localMaxHp = maxHp;
    character.setMaxHealth(character.maxHealth + localMaxHp);
    character.heal(character.health + localMaxHp);
  }
}
