import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/statuses/vulnerable.status.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';

class FearPotion extends ConsumableItem {
  int vulnerable = 3;
  FearPotion()
      : super(
            itemName: 'Fear Potion',
            itemDescription:
                'Apply 3 (SacredBark.png 6) Icon Vulnerable.png Vulnerable.',
            itemTargetType: TargetEnum.singleTarget);

  @override
  String getItemName(BuildContext context) =>
      AppLocalizations.of(context)!.fearPotionName;

  @override
  String getItemDescription(BuildContext context) {
    int localVulnerable = vulnerable;

    String result = AppLocalizations.of(context)!
        .applyVulnerableEffectDescription(localVulnerable.toString());

    return result;
    // return 'Apply $localVulnerable Vulnerable.';
  }

  @override
  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  @override
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    if (target.length == 1) {
      int localVulnerable = vulnerable;

      VulnerableStatus vs = VulnerableStatus();
      vs.addStack(localVulnerable.toDouble());
      target[0].addStatus(vs);
    }
  }
}
