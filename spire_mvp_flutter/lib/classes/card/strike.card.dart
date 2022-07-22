import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

int damage = 5;

class StrikeCard extends PlayableCard {
  StrikeCard(
      {cardName = 'Strike',
      cardDescription = 'Deal 5 damage.',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  String getCardDescription() {
    int localDamage =
        damage + Player.getPlayerInstance().getCharacter().strength;
    int weak = Player.getPlayerInstance().getCharacter().weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }

    return 'Deal $localDamage damage.';
  }

  @override
  play(List<BaseCharacter> target) {
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
