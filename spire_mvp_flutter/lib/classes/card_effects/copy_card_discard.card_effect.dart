import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';

class CopyCardDiscardCardEffect extends CardEffect {
  CopyCardDiscardCardEffect()
      : super(state: CardState.playingEffects, isShown: true);

  @override
  StatefulWidget getCardEffectDescription() {
    return const CopyCardDiscardCardEffectDescription();
  }

  @override
  void playEffect(PlayableCard card, Ref ref) {
    ref.read(playerCharacterProvider.notifier).addCardToDiscardPile(card);
  }
}

class CopyCardDiscardCardEffectDescription extends ConsumerStatefulWidget {
  const CopyCardDiscardCardEffectDescription({Key? key}) : super(key: key);

  @override
  CopyCardDiscardCardEffectDescriptionState createState() {
    return CopyCardDiscardCardEffectDescriptionState();
  }
}

class CopyCardDiscardCardEffectDescriptionState
    extends ConsumerState<CopyCardDiscardCardEffectDescription> {
  @override
  Widget build(BuildContext context) {
    return HighlightDescriptionText(
        text: AppLocalizations.of(context)!
            .copyCurrentCardToDiscardEffectDescription);
  }
}
