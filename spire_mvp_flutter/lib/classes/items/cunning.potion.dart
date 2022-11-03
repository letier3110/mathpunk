import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class CunningPotion extends ConsumableItem {
  int count = 3;
  CunningPotion()
      : super(
            itemName: 'Cunning Potion',
            itemDescription: 'Add 3 Shiv to your hand.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemName(BuildContext context) =>
      AppLocalizations.of(context)!.cunningPotionName;

  @override
  String getItemDescription(BuildContext context) {
    int localCount = count;

    String result = AppLocalizations.of(context)!
        .addCardToHandEffectDescription(
            localCount.toString(), AppLocalizations.of(context)!.shivCardName);

    return result;
  }

  @override
  String getAssetImage() {
    return 'assets/orange_potion.png';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localCount = count;
    for (var i = 0; i < localCount; i++) {
      character.getDeck().getHand().add(ShivCard());
    }
  }
}
