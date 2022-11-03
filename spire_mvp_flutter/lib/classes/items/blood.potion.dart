import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class BloodPotion extends ConsumableItem {
  double healAmount = 0.2;
  BloodPotion()
      : super(
            itemName: 'Blood Potion',
            itemDescription: 'Heal for 20% of your Max HP.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription(BuildContext context) {
    int localHealAmount = (healAmount * 100).floor();
    String result = AppLocalizations.of(context)!
        .healPercentageOfMaxEffectDescription(localHealAmount.toString());

    return result;
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
