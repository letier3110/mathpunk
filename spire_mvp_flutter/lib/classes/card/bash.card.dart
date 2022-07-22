import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import '../player/player_character/player_character.dart';
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
    var localVulnerable = vulnerable;

    return 'Deal ${calculateDamage()} damage.\nApply $localVulnerable Vulnerable.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].addVulnerable(vulnerable);
      target[0].recieveDamage(calculateDamage());
    }
  }
}
