import 'package:spire_mvp_flutter/classes/player/player.dart';

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
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.skill);

  @override
  String getCardDescription() {
    int localStrength = strength;
    int localStrengthCurse = strengthCurse;
    return 'Gain $localStrength Strength.\nAt the end of your turn, lose $localStrengthCurse Strength.';
  }

  @override
  play(List<BaseCharacter> target) {
    var tg = target as List<PlayerCharacter>;
    if ((tg.runtimeType == List<PlayerCharacter>) && tg.length == 1) {
      int localStrength = strength;
      int localStrengthCurse = strengthCurse;
      tg[0].addStrength(localStrength);
      tg[0].addStrengthCurse(localStrengthCurse);
    }
  }
}
