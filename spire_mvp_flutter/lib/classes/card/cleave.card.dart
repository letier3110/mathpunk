import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 8;

class CleaveCard extends PlayableCard {
  CleaveCard({
    cardName = 'Cleave',
    cardDescription = 'Deal 8(11) damage to ALL enemies.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.attack);

  @override
  String getCardDescription() {
    return 'Deal ${calculateDamage(damage: damage, mana: mana)} damage to ALL enemies.';
  }

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.recieveDamage(calculateDamage(damage: damage, mana: mana));
    }
  }
}
