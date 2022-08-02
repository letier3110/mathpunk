import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

int damage = 4;

class ShivCard extends PlayableCard {
  ShivCard(
      {cardName = 'Shiv',
      cardDescription = 'Deal 4 damage.Exhaust.',
      cardMana = 1,
      cardDamage = 4})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardExhaused: true,
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
    return 'Deal ${calculateDamage()} damage.\nExhaust.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage());
    }
  }
}
