import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

int damage = 14;

class HeavyBladeCard extends PlayableCard {
  HeavyBladeCard({
    cardName = 'Heavy Blade',
    cardDescription =
        'Deal 14 damage. Strength affects Heavy Blade 3(5) times.',
    cardMana = 2,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  int calculateDamage() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localDamage = damage + (character.strength * 3);
    int weak = character.weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }
    return localDamage;
  }

  @override
  StatelessWidget getCardDescription() {
    return HighlightDescriptionText(
        text:
            'Deal ${calculateDamage()} damage.\nStrength affects Heavy Blade 3 times.');
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage());
    }
  }
}
