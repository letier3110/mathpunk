import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/enemy/enemy.dart';
import 'package:mathpunk_cardgame/storage/consumable_item.storage.dart';
import 'package:mathpunk_cardgame/storage/relic.storage.dart';

import '../../deck.dart';
import '../../relic/relic.dart';
import '../../items/consumable_item.dart';

import '../../base_character.dart';

class PlayerCharacter extends BaseCharacter {
  late Deck deck;
  late List<Relic> relics;
  late List<ConsumableItem> items;
  late int mana = 0;
  late int manaPower = 3;
  late int drawPower = 3;
  late int gold = 100;
  late int cardsPlayedInRound = 0;

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

  getRelics() {
    return relics;
  }

  startTurn() {
    deck.draw(drawPower);
    mana = manaPower;
  }

  attachItems(List<ConsumableItem> newItems) {
    items = newItems;
  }

  addMana(int mana) {
    this.mana += mana;
  }

  addItem(ConsumableItem item) {
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
    strength -= strengthCurse;
    strengthCurse = 0;
    strength += strengthEmpower;
    if (vulnerable > 0) {
      vulnerable -= 1;
    }
    if (weak > 0) {
      weak -= 1;
    }
    startTurn();
  }

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

  setItems(List<ConsumableItem> items) {
    this.items = items;
  }

  addCardsPlayedInRound(int cardsPlayedInRound) {
    this.cardsPlayedInRound += cardsPlayedInRound;
  }

  factory PlayerCharacter.fromJson(dynamic json) {
    PlayerCharacter character =
        (BaseCharacter.fromJson(json)) as PlayerCharacter;
    character.setMana(json['mana'] as int);
    character.setManaPower(json['manaPower'] as int);
    character.setDrawPower(json['drawPower'] as int);
    character.setGold(json['gold'] as int);
    character.setDeck(Deck.fromJson(json['deck']));
    character.setRelics(
        (json['relics'] as List).map((e) => relicFromJson(e)).toList());
    character.setItems(
        (json['items'] as List).map((e) => consumableItemFromJson(e)).toList());

    character.addCardsPlayedInRound(json['cardsPlayedInRound'] as int);

    return character;
  }

  @override
  Map toJson() => {
        ...super.toJson(),
        'deck': deck.toJson(),
        'relics': relics.map((e) => relicToJson(e)).toList(),
        'items': items.map((e) => consumableItemToJson(e)).toList(),
        'mana': mana,
        'manaPower': manaPower,
        'drawPower': drawPower,
        'gold': gold,
        'cardsPlayedInRound': cardsPlayedInRound
      };
}
