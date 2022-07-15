import 'dart:core';
import 'package:spire_mvp_flutter/storage/playable_card.storage.dart';

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
    discardPile = [];
    hand = [];
  }

  refreshDrawPile() {
    drawPile = shuffle(discardPile);
    discardPile = [];
  }

  void addToDiscardPile(PlayableCard card) {
    discardPile.add(card);
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

  void setDrawPile(List<PlayableCard> drawPile) {
    this.drawPile = drawPile;
  }

  void setHand(List<PlayableCard> hand) {
    this.hand = hand;
  }

  void setDiscardPile(List<PlayableCard> discardPile) {
    this.discardPile = discardPile;
  }

  factory Deck.fromJson(dynamic json) {
    List<PlayableCard> playCards =
        (json['cards'] as List).map((e) => playableCardFromJson(e)).toList();
    List<PlayableCard> drawCards =
        (json['drawPile'] as List).map((e) => playableCardFromJson(e)).toList();
    List<PlayableCard> handCards =
        (json['hand'] as List).map((e) => playableCardFromJson(e)).toList();
    List<PlayableCard> discardCards = (json['discardPile'] as List)
        .map((e) => playableCardFromJson(e))
        .toList();
    Deck deck = Deck(playCards);
    deck.setDrawPile(drawCards);
    deck.setHand(handCards);
    deck.setDiscardPile(discardCards);

    return deck;
  }

  Map toJson() => {
        'drawPile': drawPile.map((e) => playableCardToJson(e)).toList(),
        'hand': hand.map((e) => playableCardToJson(e)).toList(),
        'discardPile': discardPile.map((e) => playableCardToJson(e)).toList(),
        'cards': cards.map((e) => playableCardToJson(e)).toList(),
      };
}

shuffle(List<PlayableCard> cards) {
  var newArrayOfCards = cards.toList();
  newArrayOfCards.shuffle();
  return newArrayOfCards;
}
