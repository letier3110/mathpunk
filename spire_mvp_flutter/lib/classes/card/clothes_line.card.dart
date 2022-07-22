import 'package:spire_mvp_flutter/classes/player/player.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
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
  String getCardDescription() {
    int localDamage = damage;
    int localWeak = weak;
    int playerWeak = Player.getPlayerInstance().getCharacter().weak;
    if (playerWeak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }
    return 'Deal $localDamage damage.\nApply $localWeak Weak.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      var localDamage = damage;
      int playerWeak = Player.getPlayerInstance().getCharacter().weak;
      if (playerWeak > 0) {
        localDamage = (localDamage * 0.75).floor();
      }
      target[0].recieveDamage(localDamage);
      target[0].addWeak(weak);
    }
  }
}
