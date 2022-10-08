import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_curse.status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

class FlexUpgradeCard extends PlayableCard {
  int strength = 4;
  int strengthCurse = 4;

  FlexUpgradeCard({
    cardName = 'Flex+',
    cardDescription =
        'Gain 2(4) Strength. At the end of your turn, lose 2(4) Strength.',
    cardMana = 0,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill);

  @override
  StatelessWidget getCardName() {
    return Text(
      name,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription() {
    int localStrength = strength;
    int localStrengthCurse = strengthCurse;

    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Gain $localStrength Strength.'),
          HighlightDescriptionText(
              text:
                  'At the end of your turn, lose $localStrengthCurse Strength.'),
        ],
      ),
    );
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
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
