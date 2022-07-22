import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
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
    int localDamage = damage;
    int weak = Player.getPlayerInstance().getCharacter().weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }
    return 'Deal $localDamage damage to ALL enemies.';
  }

  @override
  play(List<BaseCharacter> target) {
    var localDamage = damage;
    int weak = Player.getPlayerInstance().getCharacter().weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }
    for (var t in target) {
      t.recieveDamage(localDamage);
    }
  }
}
