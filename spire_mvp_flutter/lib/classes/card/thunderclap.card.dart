import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 4;
int vulnerable = 1;

class ThunderclapCard extends PlayableCard {
  ThunderclapCard({
    cardName = 'Thunderclap',
    cardDescription = 'Deal 4(7) damage and apply 1 Vulnerable to ALL enemies.',
    cardMana = 1,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.attack);

  @override
  String getCardDescription() {
    int localVulnerable = vulnerable;
    return 'Deal ${calculateDamage(damage: damage, mana: mana)} damage and apply $localVulnerable Vulnerable to ALL enemies.';
  }

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.recieveDamage(calculateDamage(damage: damage, mana: mana));
      int localVulnerable = vulnerable;
      target[0].addVulnerable(localVulnerable);
    }
  }
}
