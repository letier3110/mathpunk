import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';
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
            cardTargetType: TargetEnum.allTargets);

  @override
  StatelessWidget getCardDescription() {
    var localBlock = block;
    return HighlightDescriptionText(text: 'Gain $localBlock Block.');
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addBlock(block);
  }
}
