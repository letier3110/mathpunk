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
  late int maxMana = 3;
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

  // removeItem(item: Item) {
  //   // TODO
  //   // this.relics.filter by id?
  // }

  getItems() {
    return items;
  }
}
