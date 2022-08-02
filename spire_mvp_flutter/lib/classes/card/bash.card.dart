import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import '../player/player_character/player_character.dart';
import '../util.dart';
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
    var localVulnerable = vulnerable;

    return 'Deal ${calculateDamage(damage: damage, mana: mana)} damage.\nApply $localVulnerable Vulnerable.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
      int localVulnerable = vulnerable;
      target[0].addVulnerable(localVulnerable);
    }
  }
}
