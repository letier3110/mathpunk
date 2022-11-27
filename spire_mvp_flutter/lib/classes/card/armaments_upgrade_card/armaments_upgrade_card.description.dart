import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_card/armaments_card.stats.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_upgrade_card/armaments_upgrade_card.stats.dart';

import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class ArmamentsUpgradeCardDescription extends ConsumerStatefulWidget {
  const ArmamentsUpgradeCardDescription({Key? key}) : super(key: key);

  @override
  ArmamentsUpgradeCardDescriptionState createState() {
    return ArmamentsUpgradeCardDescriptionState();
  }
}

class ArmamentsUpgradeCardDescriptionState
    extends ConsumerState<ArmamentsUpgradeCardDescription> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider.notifier);
    final int block = ArmamentsUpgradeCardStats.block;

    int finalBlock = predictBlock(
        character: playerCharacter.getCharacter(),
        block: block,
        mana: ArmamentsUpgradeCardStats.mana);

    return Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(text: AppLocalizations.of(context)!.gainStartDescription),
            TextSpan(
                text: AppLocalizations.of(context)!
                    .dealBlockNumber(finalBlock.toString()),
                style: TextStyle(
                    color: finalBlock > block
                        ? Colors.greenAccent
                        : finalBlock < block
                            ? Colors.redAccent
                            : Colors.white)),
            TextSpan(
                text: AppLocalizations.of(context)!.blockEffectDescriptionEnd)
          ])),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .upgradeAllHandCardEffectDescription),
        ],
      ),
    );
  }
}
