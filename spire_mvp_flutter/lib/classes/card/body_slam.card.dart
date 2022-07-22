import 'package:spire_mvp_flutter/classes/player/player.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
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
  String getCardDescription() {
    return 'Deal damage equal to your current Block.';
  }

  @override
  play(List<BaseCharacter> target) {
    int damage = Player.getPlayerInstance().getCharacter().block;
    if (target.length == 1) {
      int localDamage =
          damage + Player.getPlayerInstance().getCharacter().strength;
      int weak = Player.getPlayerInstance().getCharacter().weak;
      if (weak > 0) {
        localDamage = (localDamage * 0.75).floor();
      }
      target[0].recieveDamage(localDamage);
    }
  }
}
