// singleton
class Game {
  gameMode: GameMode | null;

  attachGameMode(gameMode: GameMode) {
    this.gameMode = gameMode;
  }

  getGameMode() {
    return this.gameMode;
  }
}

// singleton
class GameMode {
  gameSession: GameSession | null;

  attachGameSession(gameSession: GameSession) {
    this.gameSession = gameSession;
  }

  getGameSession() {
    return this.gameSession;
  }
}

// singleton
class GameSession {
  playerInfo: Player | null;
  gameMap: GameMap | null;
  currentRoom: Room | null;

  attachPlayer(player: Player) {
    this.playerInfo = player;
  }

  getPlayerInfo() {
    return this.playerInfo;
  }

  attachGameMap(gameMap: GameMap) {
    this.gameMap = gameMap;
  }

  getGameMap() {
    return this.gameMap;
  }

  getNextAvailableRooms(): Room | null {
    const rooms = this.gameMap.getRooms();
    if(this.currentRoom === null) return rooms[0];
    
    // TODO: change search from in array to tree with .nextRoom pointer in current rooms row
    const foundRoom = { index: 0, value: rooms[0] };
    for (const room of rooms) {
      if (Room.isEqual(room, this.currentRoom)) {
        foundRoom.index = 0;
        foundRoom.value = room;
      }
    }
    const nextRoomIndex = foundRoom.index + 1;
    if (rooms.length <= nextRoomIndex) return null;
    return rooms[nextRoomIndex];
  }

  enterRoom(room: Room) {
    this.currentRoom = room;
  }

  getCurrentRoom() {
    return this.currentRoom;
  }
}

class GameMap {
  rooms: Room[];
  constructor() {
    this.generateMap();
  }

  // TODO: seed
  generateMap() {
    this.rooms = [
      new Room({ id: '1' }),
      new Room({ id: '2' }),
      new Room({ id: '3' }),
      new Room({ id: '4' }),
      new Room({ id: '5' }),
      new Room({ id: '6' }),
      new Room({ id: '7' }),
      new Room({ id: '8' }),
      new Room({ id: '9' }),
      new Room({ id: '10' }),
      new Room({ id: '11' })
    ];
  }

  getRooms() {
    return this.rooms;
  }
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
  id: string;
};

interface IRoom {
  _id: string;
  enemies: Enemy[];
  rewards: Reward[];
}

class Room implements IRoom {
  _id: string;
  enemies: Enemy[];
  rewards: Reward[];

  constructor({ id }: RoomConstructorProps) {
    this._id = id;
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

  public static isEqual(a: Room, b: Room) {
    return a._id === b._id;
  }
}

class Player {
  name: string;
  character: PlayerCharacter | null;
  constructor({ name }: { name: string }) {
    this.name = name;
  }

  getName(): string {
    return this.name;
  }

  selectCharacter(character: PlayerCharacter) {
    this.character = character;
  }

  getCharacter() {
    return this.character;
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

const game = new Game();

const gameMode = new GameMode();
game.attachGameMode(gameMode);

const gameSession = new GameSession();
gameMode.attachGameSession(gameSession);

const player = new Player({ name: 'player' });
const map = new GameMap();
map.generateMap();

gameSession.attachPlayer(player);
gameSession.attachGameMap(map);
// gameSession.

player.selectCharacter(new Warrior());

console.log('room');
