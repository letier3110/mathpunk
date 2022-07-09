import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

int damage = 8;
int vulnerable = 2;

class BashCard extends PlayableCard {
  BashCard({
    cardName = 'Bash',
    cardDescription = 'Deal 8 damage.\nApply 2 Vulnerable.',
    cardMana = 2,
  }) : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

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
