import 'dart:core';
import 'card/playable_card.dart';

class Deck {
  List<PlayableCard> cards = [];

  List<PlayableCard> drawPile = [];
  List<PlayableCard> hand = [];
  List<PlayableCard> discardPile = [];

  Deck(List<PlayableCard> newCards) {
    cards = newCards;
    drawPile = [];
    hand = [];
    discardPile = [];
  }

  getCards() {
    return cards;
  }

  getDrawPile() {
    return drawPile;
  }

  getHand() {
    return hand;
  }

  getDiscardPile() {
    return discardPile;
  }

  void initialLoadDrawPile() {
    drawPile = shuffle(cards);
  }

  refreshDrawPile() {
    drawPile = shuffle(discardPile);
    discardPile = [];
  }

  playCard(PlayableCard card) {
    hand.remove(card);
    discardPile.add(card);
  }

  draw(int n) {
    if (n > drawPile.length) {
      int drawNumber = n - drawPile.length;
      List<PlayableCard> remItems = drawPile.toList();
      hand = hand + remItems;
      refreshDrawPile();
      if (drawNumber > drawPile.length) {
        List<PlayableCard> remItems = drawPile.toList();
        drawPile = [];
        hand = hand + remItems;
      } else {
        List<PlayableCard> remItems = shuffle(drawPile).sublist(0, drawNumber);
        for (var card in remItems) {
          drawPile.remove(card);
        }
        hand = hand + remItems;
      }
    } else {
      List<PlayableCard> remItems = shuffle(drawPile).sublist(0, n);

      for (var card in remItems) {
        drawPile.remove(card);
      }
      hand = hand + remItems;
    }
  }
}

shuffle(List<PlayableCard> cards) {
  var newArrayOfCards = cards.toList();
  newArrayOfCards.shuffle();
  return newArrayOfCards;
}
