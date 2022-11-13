import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.stats.dart';

import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class AngerCardDescription extends ConsumerStatefulWidget {
  const AngerCardDescription({Key? key}) : super(key: key);

  @override
  AngerCardDescriptionState createState() {
    return AngerCardDescriptionState();
  }
}

class AngerCardDescriptionState extends ConsumerState<AngerCardDescription> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider.notifier);
    final int damage = AngerCardStats.damage;

    int finalDamage = predictDamage(
        character: playerCharacter.getCharacter(),
        damage: damage,
        mana: AngerCardStats.mana);
    return Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(text: AppLocalizations.of(context)!.dealStartDescription),
            TextSpan(
                text: AppLocalizations.of(context)!
                    .dealDamageNumber(finalDamage.toString()),
                style: TextStyle(
                    color: finalDamage > damage
                        ? Colors.greenAccent
                        : finalDamage < damage
                            ? Colors.redAccent
                            : Colors.white)),
            TextSpan(
                text: AppLocalizations.of(context)!.damageEffectDescriptionEnd)
          ])),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .copyCurrentCardToDiscardEffectDescription),
        ],
      ),
    );
  }
}
