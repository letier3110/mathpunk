import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

int block = 8;
int draw = 1;

class ShrugItOffCard extends PlayableCard {
  ShrugItOffCard(
      {cardName = 'Shrug it Off',
      cardDescription = 'Gain 8(11) Block. Draw 1 card.',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill);

  @override
  StatelessWidget getCardDescription() {
    int localBlock = block;
    int localDraw = draw;
    return HighlightDescriptionText(
        text: 'Gain $localBlock Block.\nDraw $localDraw card.');
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localBlock = block;
    int localDraw = draw;
    character.addBlock(localBlock);
    character.deck.draw(localDraw);
  }
}
