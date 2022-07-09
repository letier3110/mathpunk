import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

int damage = 8;

class StrikeCard extends PlayableCard {
  StrikeCard(
      {cardName = 'Strike',
      cardDescription = 'Deal 6 damage.',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  String getCardDescription() {
    var localDamage = damage;

    return 'Deal $localDamage damage.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(damage);
    }
  }
}
