import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';

class ManaDrawCardEffect extends CardEffect {
  ManaDrawCardEffect() : super(state: CardState.playingEffects, isShown: false);

  @override
  StatefulWidget getCardEffectDescription() {
    return const ManaDrawCardEffectDescription();
  }

  @override
  void playEffect(PlayableCard card, Ref ref) {
    ref.read(playerCharacterProvider.notifier).addMana(-card.getMana());
  }
}

class ManaDrawCardEffectDescription extends ConsumerStatefulWidget {
  const ManaDrawCardEffectDescription({Key? key}) : super(key: key);

  @override
  ManaDrawCardEffectDescriptionState createState() {
    return ManaDrawCardEffectDescriptionState();
  }
}

class ManaDrawCardEffectDescriptionState
    extends ConsumerState<ManaDrawCardEffectDescription> {
  @override
  Widget build(BuildContext context) {
    return HighlightDescriptionText(
        text: AppLocalizations.of(context)!
            .copyCurrentCardToDiscardEffectDescription);
  }
}
