import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

int damage = 5;
int block = 5;

class IronWaveCard extends PlayableCard {
  IronWaveCard(
      {cardName = 'Iron Wave',
      cardDescription = 'Gain 5(7) Block. Deal 5(7) damage.',
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
    int localBlock = block;

    return 'Gain $localBlock Block.\nDeal $localDamage damage.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      PlayerCharacter character = Player.getPlayerInstance().getCharacter();
      int localDamage = damage + character.strength;
      int localBlock = block;
      int weak = character.weak;
      if (weak > 0) {
        localDamage = (localDamage * 0.75).floor();
      }
      target[0].recieveDamage(localDamage);
      character.addBlock(localBlock);
    }
  }
}
