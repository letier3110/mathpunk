import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/deck.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

int damage = 6;

class PerfectStrikeCard extends PlayableCard {
  PerfectStrikeCard(
      {cardName = 'Perfect Strike',
      cardDescription =
          'Deal 6 damage. Deals an additional 2(3) damage for ALL of your cards containing "Strike".',
      cardMana = 2,
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
    Deck deck = character.getDeck();
    List<PlayableCard> drawPile = deck.getDrawPile();
    List<PlayableCard> hand = deck.getHand();
    List<PlayableCard> discardPile = deck.getDiscardPile();
    int bonusDamage = 0;
    for (PlayableCard card in drawPile) {
      if (card.name.contains('Strike')) {
        bonusDamage += 2;
      }
    }
    for (PlayableCard card in hand) {
      if (card.name.contains('Strike')) {
        bonusDamage += 2;
      }
    }
    for (PlayableCard card in discardPile) {
      if (card.name.contains('Strike')) {
        bonusDamage += 2;
      }
    }
    return localDamage + bonusDamage;
  }

  @override
  StatelessWidget getCardDescription() {
    return HighlightDescriptionText(
        text:
            'Deal ${calculateDamage()} damage.\nDeals an additional 2 damage for ALL of your cards containing "Strike".');
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage());
    }
  }
}
