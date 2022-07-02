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
  }

  draw(int n) {
    var drawNumber = (n - drawPile.length).abs();

    drawPile = drawPile.sublist(0, drawNumber);
    hand = hand + drawPile;
    if (n > drawPile.length) {
      refreshDrawPile();
      if (n - drawNumber > drawPile.length) {
        drawPile = drawPile.sublist(0, drawPile.length);
        hand = hand + drawPile;
      } else {
        drawPile = drawPile.sublist(0, n - drawNumber);
        hand = hand + drawPile;
      }
    }
  }
}

shuffle(List<Card> cards) {
  var newArrayOfCards = cards.toList();
  newArrayOfCards.shuffle();
  return newArrayOfCards;
}
