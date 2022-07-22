import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

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
    return 'Deal ${calculateDamage()} damage.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage());
    }
  }
}
