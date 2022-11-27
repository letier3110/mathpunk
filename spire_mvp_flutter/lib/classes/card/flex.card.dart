import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/flex.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_curse.status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

class FlexCard extends PlayableCard {
  int strength = 2;
  int strengthCurse = 2;

  FlexCard(
      {cardName = 'Flex',
      cardDescription =
          'Gain 2(4) Strength. At the end of your turn, lose 2(4) Strength.',
      cardMana = 0,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill,
            cardUpgrageLink: FlexUpgradeCard());

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.flexCardName,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int localStrength = strength;
    int localStrengthCurse = strengthCurse;

    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .applyStrengthEffectDescription(localStrength.toString())),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .loseStrengthAtTheRoundEndEffectDescription(
                      localStrengthCurse.toString())),
        ],
      ),
    );
  }

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && mana == 1) return 0;

    return mana;
  }

  @override
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    int localStrength = strength;
    int localStrengthCurse = strengthCurse;

    StrengthStatus ss = StrengthStatus();
    ss.addStack(localStrength.toDouble());
    character.addStatus(ss);

    StrengthCurseStatus scs = StrengthCurseStatus();
    scs.addStack(localStrengthCurse.toDouble());
    character.addStatus(scs);
  }
}
