import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_time.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/rook.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/card_type.enum.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class TripleMathUpgradeCard extends PlayableCard {
  TripleMathUpgradeCard(
      {cardName = '3x+',
      cardDescription = 'Function. Triples next value',
      cardMana = 12,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.function,
            cardTemporary: cardTemporary);

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.tripleCardUpgradeName,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
              text:
                  '${AppLocalizations.of(context)!.functionMechanic}${AppLocalizations.of(context)!.tripleCardUpgradeName}'),
        ],
      ),
    );
  }

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();
    bool isRookStatus = castStatusToBool(statuses, RookStatus);

    if (isRookStatus && character.timesReceivedDamageInRound == 0) return 0;

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && mana == 1) return 0;

    return mana;
  }

  @override
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    List<Status> statuses = character.getStatuses();
    int mathMultiplierTime =
        castStatusToInt(statuses, MathMultiplierTimeStatus);

    MathMultiplierScoreStatus mss = MathMultiplierScoreStatus();
    mss.addStack(3);
    character.addStatus(mss);

    if (mathMultiplierTime == 0) {
      MathMultiplierTimeStatus mts = MathMultiplierTimeStatus();
      mts.addStack(1);
      character.addStatus(mts);
    }
  }
}
