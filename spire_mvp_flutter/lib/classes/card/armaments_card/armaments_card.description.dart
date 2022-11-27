import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/armaments_card/armaments_card.stats.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class ArmamentsCardDescription extends ConsumerStatefulWidget {
  const ArmamentsCardDescription({Key? key}) : super(key: key);

  @override
  ArmamentsCardDescriptionState createState() {
    return ArmamentsCardDescriptionState();
  }
}

class ArmamentsCardDescriptionState
    extends ConsumerState<ArmamentsCardDescription> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider.notifier);
    final int block = ArmamentsCardStats.block;

    int finalBlock = predictBlock(
        character: playerCharacter.getCharacter(),
        block: block,
        mana: ArmamentsCardStats.mana);

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
                  .upgradeSingleHandCardEffectDescription),
        ],
      ),
    );
  }
}
