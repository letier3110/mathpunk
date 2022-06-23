import 'dart:math';
import 'dart:core';
import 'card/card.dart';

class Deck {
  late List<Card> cards;

  late List<Card> drawPile;
  late List<Card> hand;
  late List<Card> discardPile;

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

  initialLoadDrawPile() {
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

// TODO: implement shuffle as in ts
shuffle(List<Card> cards) {
  return cards;
}

// const shuffle = (List array) => {
//   var currentIndex = array.length;
//   var temporaryValue;
//   var randomIndex;

//   // While there remain elements to shuffle...
//   while (0 != currentIndex) {

//     // Pick a remaining element...
//     randomIndex = Math.floor(Math.random() * currentIndex);
//     currentIndex -= 1;

//     // And swap it with the current element.
//     temporaryValue = array[currentIndex];
//     array[currentIndex] = array[randomIndex];
//     array[randomIndex] = temporaryValue;
//   }

//   return array;
// }
