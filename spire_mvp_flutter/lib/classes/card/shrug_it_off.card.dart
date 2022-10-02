import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/shrug_it_off.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

class ShrugItOffCard extends PlayableCard {
  int block = 8;
  int draw = 1;

  ShrugItOffCard(
      {cardName = 'Shrug it Off',
      cardDescription = 'Gain 8(11) Block. Draw 1 card.',
      cardMana = 1})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill,
            cardUpgrageLink: ShrugItOffUpgradeCard());

  @override
  StatelessWidget getCardDescription() {
    int localBlock = block;
    int localDraw = draw;
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Gain $localBlock Block.'),
          HighlightDescriptionText(text: 'Draw $localDraw card.')
        ],
      ),
    );
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
