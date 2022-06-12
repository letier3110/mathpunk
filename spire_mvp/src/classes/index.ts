// singleton
class Game {
  gameMode: GameMode | null;
}

// singleton
class GameMode {
  gameSession: GameSession | null;
}

// singleton
class GameSession {
  playerInfo: Character | null;
  gameMap: GameMap | null;
  currentRoom: Room | null;
}

class GameMap {
  rooms: Room[];
}

interface Character {
  health: number;
  maxHealth: number;
}

class BaseCharacter implements Character {
  name: string;
  health: number;
  maxHealth: number;

  constructor() {
    this.health = 10;
    this.maxHealth = 10;
    this.name = '';
  }
}

class PlayerCharacter extends BaseCharacter {
  deck: Deck;
  relics: Relic[];
  items: Item[];

  attachDeck(deck: Deck) {
    this.deck = deck;
  }

  getDeck() {
    return this.deck;
  }

  attachRelics(relics: Relic[]) {
    this.relics = relics;
  }

  addRelic(relic: Relic) {
    this.relics.concat(relic);
  }

  removeRelic(relic: Relic) {
    // TODO
    // this.relics.filter by id?
  }

  getRelics() {
    return this.relics;
  }

  attachItems(items: Item[]) {
    this.items = items;
  }

  addItem(item: Item) {
    this.items.concat(item);
  }

  removeItem(item: Item) {
    // TODO
    // this.relics.filter by id?
  }

  getItems() {
    return this.items;
  }
}

class Warrior extends PlayerCharacter {
  constructor() {
    super();
    this.health = 100;
    this.maxHealth = 100;
    this.name = 'Warrior';

    this.relics = [new Relic()];

    const cards: Card[] = [new Card()];
    this.deck = new Deck(cards);
  }
}

class Mage extends PlayerCharacter {
  constructor() {
    super();
    this.health = 100;
    this.maxHealth = 100;
    this.name = 'Mage';

    this.relics = [new Relic()];

    const cards: Card[] = [new Card()];
    this.deck = new Deck(cards);
  }
}

class Rogue extends PlayerCharacter {
  constructor() {
    super();
    this.health = 100;
    this.maxHealth = 100;
    this.name = 'Rogue';

    this.relics = [new Relic()];

    const cards: Card[] = [new Card()];
    this.deck = new Deck(cards);
  }
}

class Enigma extends PlayerCharacter {
  constructor() {
    super();
    this.health = 100;
    this.maxHealth = 100;
    this.name = 'Enigma';

    this.relics = [new Relic()];

    const cards: Card[] = [new Card()];
    this.deck = new Deck(cards);
  }
}

class Relic {}

class Item {}

class Deck {
  cards: Card[];
  constructor(cards: Card[]) {
    this.cards = cards;
  }

  getCards() {
    return this.cards;
  }
}

class Card {}

type Reward = Relic | Item | Card | number;

type RoomConstructorProps = {
  name: string;
};

interface IRoom {
  name: string;
  enemies: Enemy[];
  rewards: Reward[];
}

class Room implements IRoom {
  name: string;
  enemies: Enemy[];
  rewards: Reward[];

  constructor({ name }: RoomConstructorProps) {
    this.name = name;
    this.enemies = [];
    this.rewards = [];
  }

  public attachEnemies({ enemies }: { enemies: Enemy[] }): void {
    this.enemies = enemies;
  }

  public attachRewards({ rewards }: { rewards: Reward[] }): void {
    this.rewards = rewards;
  }

  public getEnemies(): Enemy[] {
    return this.enemies;
  }

  public getRewards(): Reward[] {
    return this.rewards;
  }
}

class Player {
  name: string;
  constructor({ name }: { name: string }) {
    this.name = name;
  }

  public getName(): string {
    return this.name;
  }
}

class Enemy {
  name: string;
  constructor({ name }: { name: string }) {
    this.name = name;
  }

  public getName(): string {
    return this.name;
  }
}

const enemy = new Enemy({ name: 'goblin' });
const player = new Player({ name: 'player' });
const room = new Room({ name: 'room' });

console.log('room');
