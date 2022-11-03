import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

class DoubtCard extends PlayableCard {
  int damage = 6;

  DoubtCard(
      {cardName = 'Doubt',
      cardDescription = 'Unplayable.At the end of your turn, gain 1 Weak.',
      cardMana = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.curse);

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.doubtCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  bool isCardPlayable() => false;

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int localWeak = 1;
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!.unplayableMechanic),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .addWeakAtTheRoundEndEffectDescription(localWeak.toString())),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {}
}
