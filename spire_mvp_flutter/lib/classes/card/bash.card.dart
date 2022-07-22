import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
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
    int localDamage =
        damage + Player.getPlayerInstance().getCharacter().strength;
    var localVulnerable = vulnerable;
    int weak = Player.getPlayerInstance().getCharacter().weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }

    return 'Deal $localDamage damage.\nApply $localVulnerable Vulnerable.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].addVulnerable(vulnerable);
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
