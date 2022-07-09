import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

int block = 5;

class DefendCard extends PlayableCard {
  DefendCard({
    cardName = 'Defend',
    cardDescription = 'Gain 5 Block.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.skill,
            cardTargetType: TargetEnum.playerTarget);

  @override
  String getCardDescription() {
    var localBlock = block;

    return 'Gain $localBlock Block.';
  }

  @override
  play(List<BaseCharacter> target) {
    var tg = target as List<PlayerCharacter>;
    if ((tg.runtimeType == List<PlayerCharacter>) && tg.length == 1) {
      tg[0].addBlock(block);
    }
  }
}
