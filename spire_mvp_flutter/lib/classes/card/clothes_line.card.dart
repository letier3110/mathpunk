import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 12;
int weak = 2;

class ClothesLineCard extends PlayableCard {
  ClothesLineCard({
    cardName = 'Clothesline',
    cardDescription = 'Deal 12(14) damage. Apply 2(3) Weak.',
    cardMana = 2,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    int localWeak = weak;

    return HighlightDescriptionText(
        text:
            'Deal ${calculateDamage(damage: damage, mana: mana)} damage.\nApply $localWeak Weak.');
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
      target[0].addWeak(weak);
    }
  }
}
