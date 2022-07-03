import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

import '../base_character.dart';

import '../../enums/card_type.dart';
import 'playable_card.dart';

class DefendCard extends PlayableCard {
  int block = 5;

  DefendCard(
      {cardName = 'Defend',
      cardDescription = 'Gain 5 Block.',
      cardMana = 1,
      cardBlock = 5})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.skill) {
    block = cardBlock;
  }

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
