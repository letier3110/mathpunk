import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

class BodySlamCard extends PlayableCard {
  BodySlamCard({
    cardName = 'Body Slam',
    cardDescription = 'Deal damage equal to your current Block.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    return HighlightDescriptionText(
        text: 'Deal damage equal to your current Block.');
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(
          damage: Player.getPlayerInstance().getCharacter().block, mana: mana));
    }
  }
}
