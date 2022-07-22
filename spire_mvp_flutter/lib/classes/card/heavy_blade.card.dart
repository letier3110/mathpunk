import 'package:spire_mvp_flutter/classes/player/player.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
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

  @override
  String getCardDescription() {
    int localDamage =
        damage + (Player.getPlayerInstance().getCharacter().strength * 3);
    int weak = Player.getPlayerInstance().getCharacter().weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }
    return 'Deal $localDamage damage.\nStrength affects Heavy Blade 3 times.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      int localDamage =
          damage + (Player.getPlayerInstance().getCharacter().strength * 3);
      int weak = Player.getPlayerInstance().getCharacter().weak;
      if (weak > 0) {
        localDamage = (localDamage * 0.75).floor();
      }
      target[0].recieveDamage(localDamage);
    }
  }
}
