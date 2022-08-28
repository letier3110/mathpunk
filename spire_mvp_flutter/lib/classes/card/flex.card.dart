import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

const int strength = 2;
const int strengthCurse = 2;

class FlexCard extends PlayableCard {
  FlexCard({
    cardName = 'Flex',
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
    character.addStrength(localStrength);
    character.addStrengthCurse(localStrengthCurse);
  }
}
