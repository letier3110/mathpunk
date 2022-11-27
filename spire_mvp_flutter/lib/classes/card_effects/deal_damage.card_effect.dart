import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/select_target.card_effect.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';

class DealDamageCardEffect extends CardEffect {
  int damage = 6;
  int mana = 1;
  DealDamageCardEffect({this.damage = 6, this.mana = 1})
      : super(
            state: CardState.dealingDamage,
            isShown: true,
            duration: const Duration(seconds: 1));

  @override
  StatefulWidget getCardEffectDescription() {
    return DealDamageCardEffectDescription(
      damage: damage,
      mana: mana,
    );
  }

  @override
  void playEffect(PlayableCard card, Ref ref) {
    List<SelectTargetCardEffect> selectedTarget = card.effects
        .where((element) => element.runtimeType == SelectTargetCardEffect)
        .toList() as List<SelectTargetCardEffect>;
    if (selectedTarget.isNotEmpty) {
      final target = selectedTarget[0].target;
      target[0].receiveDamage(calculateDamage(
          character: ref.read(playerCharacterProvider.notifier).getCharacter(),
          damage: damage,
          precision: card.precision,
          mana: card.getMana()));
    }
  }
}

class DealDamageCardEffectDescription extends ConsumerStatefulWidget {
  final int damage;
  final int mana;
  const DealDamageCardEffectDescription(
      {this.damage = 6, this.mana = 1, Key? key})
      : super(key: key);

  @override
  DealDamageCardEffectDescriptionState createState() {
    return DealDamageCardEffectDescriptionState();
  }
}

class DealDamageCardEffectDescriptionState
    extends ConsumerState<DealDamageCardEffectDescription> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider.notifier);
    int finalDamage = predictDamage(
        character: playerCharacter.getCharacter(),
        damage: widget.damage,
        mana: widget.mana);
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: AppLocalizations.of(context)!.dealStartDescription),
      TextSpan(
          text: AppLocalizations.of(context)!
              .dealDamageNumber(finalDamage.toString()),
          style: TextStyle(
              color: finalDamage > widget.damage
                  ? Colors.greenAccent
                  : finalDamage < widget.damage
                      ? Colors.redAccent
                      : Colors.white)),
      TextSpan(text: AppLocalizations.of(context)!.damageEffectDescriptionEnd)
    ]));
    ;
  }
}
