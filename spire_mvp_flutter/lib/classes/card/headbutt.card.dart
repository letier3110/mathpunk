import 'package:spire_mvp_flutter/classes/player/player.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

int damage = 9;

class HeadbuttCard extends PlayableCard {
  HeadbuttCard({
    cardName = 'Headbutt',
    cardDescription =
        'Deal 9(12) damage. Place a card from your discard pile on top of your draw pile.',
    cardMana = 1,
  }) : super(
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
    return 'Deal $localDamage damage.\nPlace a card from your discard pile on top of your draw pile.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      PlayerCharacter character = Player.getPlayerInstance().getCharacter();
      int localDamage = damage + character.strength;
      int weak = character.weak;
      if (weak > 0) {
        localDamage = (localDamage * 0.75).floor();
      }
      target[0].recieveDamage(localDamage);

      List<PlayableCard> discardPile = character.getDeck().getDiscardPile();
      List<PlayableCard> drawPile = character.getDeck().getDrawPile();

      PlayableCard card = discardPile.removeLast();
      drawPile.insert(0, card);
    }
  }
}
