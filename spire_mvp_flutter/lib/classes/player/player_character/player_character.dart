import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';

import '../../deck.dart';
import '../../relic.dart';
import '../../item.dart';

import '../../base_character.dart';

class PlayerCharacter extends BaseCharacter {
  late Deck deck;
  late List<Relic> relics;
  late List<Item> items;
  late int mana = 0;
  late int manaPower = 3;
  late int drawPower = 3;
  late int gold = 100;

  PlayerCharacter({playerGold = 100}) : super() {
    deck = Deck([]);
    relics = [];
    items = [];
    gold = playerGold;
  }

  attachDeck(Deck deck) {
    this.deck = deck;
  }

  Deck getDeck() {
    return deck;
  }

  attachRelics(List<Relic> newRelics) {
    relics = newRelics;
  }

  addRelic(Relic relic) {
    relics.add(relic);
  }

  // removeRelic(relic: Relic) {
  //   // TODO
  //   // this.relics.filter by id?
  // }

  getRelics() {
    return relics;
  }

  startTurn() {
    deck.draw(drawPower);
    mana = manaPower;
  }

  attachItems(List<Item> newItems) {
    items = newItems;
  }

  addItem(Item item) {
    items.add(item);
  }

  playCard(PlayableCard card, List<Enemy> targets) {
    card.play(targets);
    card.disposeToDiscard(deck.hand, deck.discardPile);
  }

  endTurn() {
    var hand = deck.hand;
    var i = 0;
    while (i < hand.length) {
      var b = hand[i].disposeToDiscard(deck.hand, deck.discardPile);
      if (!b) {
        i += 1;
      }
    }
    block = 0;
    startTurn();
  }

  // removeItem(item: Item) {
  //   // TODO
  //   // this.relics.filter by id?
  // }

  getItems() {
    return items;
  }

  setMana(int mana) {
    this.mana = mana;
  }

  setManaPower(int manaPower) {
    this.manaPower = manaPower;
  }

  setDrawPower(int drawPower) {
    this.drawPower = drawPower;
  }

  setGold(int gold) {
    this.gold = gold;
  }

  setDeck(Deck deck) {
    this.deck = deck;
  }

  setRelics(List<Relic> relics) {
    this.relics = relics;
  }

  setItems(List<Item> items) {
    this.items = items;
  }

  factory PlayerCharacter.fromJson(dynamic json) {
    PlayerCharacter character =
        (BaseCharacter.fromJson(json)) as PlayerCharacter;
    character.setMana(json['mana'] as int);
    character.setManaPower(json['manaPower'] as int);
    character.setDrawPower(json['drawPower'] as int);
    character.setGold(json['gold'] as int);
    character.setDeck(Deck.fromJson(json['deck']));
    // character.setRelics(json['relics'] as List<Relic>);
    character.setRelics([]);
    // character.setItems(json['items'] as List<Item>);
    character.setItems([]);
    // character

    return character;
  }

  @override
  Map toJson() => {
        ...super.toJson(),
        'deck': deck.toJson(),
        'relics': [],
        'items': [],
        'mana': mana,
        'manaPower': manaPower,
        'drawPower': drawPower,
        'gold': gold,
      };
}
