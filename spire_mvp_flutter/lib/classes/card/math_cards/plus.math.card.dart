import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/plus.upgrade.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_time.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/rook.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/card_type.enum.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class PlusMathCard extends PlayableCard {
  PlusMathCard(
      {cardName = 'f(+)',
      cardDescription = 'Extending Function multiplier for another card.',
      cardMana = 10,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.function,
            cardUpgrageLink: PlusMathUpgradeCard(),
            cardTemporary: cardTemporary);

  @override
  StatelessWidget getCardDescription() {
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
              text: 'Extending Function multiplier for another card.'),
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
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    MathMultiplierTimeStatus mts = MathMultiplierTimeStatus();
    mts.addStack(1);
    character.addStatus(mts);
  }
}
