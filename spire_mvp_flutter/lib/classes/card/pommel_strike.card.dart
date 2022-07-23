import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

int damage = 9;
int draw = 1;

class PommelStrikeCard extends PlayableCard {
  PommelStrikeCard(
      {cardName = 'Pommel Strike',
      cardDescription = 'Deal 9(10) damage. Draw 1(2) card(s).',
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
    int localDraw = draw;

    return 'Deal ${calculateDamage()} damage.\nDraw $localDraw card.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage());
      int localDraw = draw;
      PlayerCharacter character = Player.getPlayerInstance().getCharacter();
      character.deck.draw(localDraw);
    }
  }
}
