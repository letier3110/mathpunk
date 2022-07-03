import 'dart:core';
import 'card/card.dart';

class Deck {
  List<Card> cards = [];

  List<Card> drawPile = [];
  List<Card> hand = [];
  List<Card> discardPile = [];

  Deck(List<Card> newCards) {
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

  playCard(Card card) {
    hand.remove(card);
    discardPile.add(card);
  }

  draw(int n) {
    if (n > drawPile.length) {
      int drawNumber = n - drawPile.length;
      List<Card> remItems = drawPile.toList();
      hand = hand + remItems;
      refreshDrawPile();
      if (n - drawNumber > drawPile.length) {
        List<Card> remItems = drawPile.toList();
        drawPile = [];
        hand = hand + remItems;
      } else {
        List<Card> remItems = shuffle(drawPile).sublist(0, n - drawNumber);
        for (var card in remItems) {
          drawPile.remove(card);
        }
        hand = hand + remItems;
      }
    } else {
      List<Card> remItems = shuffle(drawPile).sublist(0, n);

      for (var card in remItems) {
        drawPile.remove(card);
      }
      hand = hand + remItems;
    }
  }
}

shuffle(List<Card> cards) {
  var newArrayOfCards = cards.toList();
  newArrayOfCards.shuffle();
  return newArrayOfCards;
}
