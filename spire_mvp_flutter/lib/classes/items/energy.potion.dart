import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class EnergyPotion extends ConsumableItem {
  int energy = 2;
  EnergyPotion()
      : super(
            itemName: 'Energy Potion',
            itemDescription: 'Gain 2 or 4 Energy.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription(BuildContext context) {
    int localEnergy = energy;

    String result = AppLocalizations.of(context)!
        .applyEnergyEffectDescription(localEnergy.toString());

    return result;
  }

  @override
  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localEnergy = energy;
    character.addMana(localEnergy);
  }
}
