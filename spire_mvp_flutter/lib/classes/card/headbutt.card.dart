import 'package:spire_mvp_flutter/classes/deck.dart';
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
    return 'Deal ${calculateDamage()} damage.\nPlace a card from your discard pile on top of your draw pile.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      Deck deck = Player.getPlayerInstance().getCharacter().getDeck();
      target[0].recieveDamage(calculateDamage());

      List<PlayableCard> discardPile = deck.getDiscardPile();
      List<PlayableCard> drawPile = deck.getDrawPile();

      PlayableCard card = discardPile.removeLast();
      drawPile.insert(0, card);
    }
  }
}
