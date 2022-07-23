import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
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

  int calculateDamage() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localDamage = damage + character.strength;
    int weak = character.weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }
    return localDamage;
  }

  @override
  String getCardDescription() {
    int localVulnerable = vulnerable;
    return 'Deal ${calculateDamage()} damage and apply $localVulnerable Vulnerable to ALL enemies.';
  }

  @override
  play(List<BaseCharacter> target) {
    for (var t in target) {
      t.recieveDamage(calculateDamage());
      int localVulnerable = vulnerable;
      target[0].addVulnerable(localVulnerable);
    }
  }
}
