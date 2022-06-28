import '../base_character.dart';

import '../../enums/card_type.dart';
import 'card.dart';

class BashCard extends Card {
  int damage = 8;
  int vulnerable = 2;

  BashCard(
      {cardName = 'Bash',
      cardDescription = 'Deal 8 damage.\nApply 2 Vulnerable.',
      cardMana = 2,
      cardVulnerable = 2,
      cardDamage = 8})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack) {
    damage = cardDamage;
    vulnerable = cardVulnerable;
  }

  @override
  String getCardDescription() {
    var localDamage = damage;
    var localVulnerable = damage;

    return 'Deal $localDamage damage.\nApply $localVulnerable Vulnerable.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].addVulnerable(vulnerable);
      target[0].recieveDamage(damage);
    }
  }
}
