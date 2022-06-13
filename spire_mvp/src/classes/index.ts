// singleton
class Game {
  gameMode: GameMode | null;

  constructor() {
    this.gameMode = null
  }

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

  constructor() {
    this.gameSession = null
  }

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

  constructor() {
    this.playerInfo = null
    this.gameMap = null
    this.currentRoom = null
  }

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
    if(!this.gameMap) return null;
    const rooms = this.gameMap.getRooms();
    if (this.currentRoom === null) return rooms[0];

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
    this.rooms = [];
    this.generateMap();
  }

  // TODO: seed
  generateMap() {
    this.rooms = [
      new EnemyRoom({ id: '1' }),
      new EnemyRoom({ id: '2' }),
      new EnemyRoom({ id: '3' }),
      new EnemyRoom({ id: '4' }),
      new MiniBossRoom({ id: '5' }),
      new EnemyRoom({ id: '6' }),
      new EnemyRoom({ id: '7' }),
      new EnemyRoom({ id: '8' }),
      new EnemyRoom({ id: '9' }),
      new EnemyRoom({ id: '10' }),
      new BossRoom({ id: '11', level: 0 })
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

  constructor() {
    super();
    this.deck = new EmptyDeck();
    this.relics = []
    this.items = []
  }

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

  // removeRelic(relic: Relic) {
  //   // TODO
  //   // this.relics.filter by id?
  // }

  getRelics() {
    return this.relics;
  }

  attachItems(items: Item[]) {
    this.items = items;
  }

  addItem(item: Item) {
    this.items.concat(item);
  }

  // removeItem(item: Item) {
  //   // TODO
  //   // this.relics.filter by id?
  // }

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

class Relic { }

class Item { }

class Deck {
  cards: Card[];
  constructor(cards: Card[]) {
    this.cards = cards;
  }

  getCards() {
    return this.cards;
  }
}

class EmptyDeck extends Deck {
  constructor() {
    super([]);
  }

  getCards() {
    return this.cards;
  }
}

class Card { }

class Enemy {
  name: string;
  constructor({ name }: { name: string }) {
    this.name = name;
  }

  public getName(): string {
    return this.name;
  }
}

type Reward = Relic | Item | Card | number;

const EnemyRewardPool: Array<Reward[]> = [
  [new Relic()]
]

const MiniBossRewardPool: Array<Reward[]> = [
  [new Relic()]
]

const BossRewardPool: Array<Reward[]> = [
  [new Relic()]
]

type RoomConstructorProps = {
  id: string;
  enemies?: Enemy[];
  rewards?: Reward[];
};

type BossRoomConstructorProps = {
  id: string;
  level: number;
}

interface IRoom {
  _id: string;
  enemies: Enemy[];
  rewards: Reward[];
}

class Room implements IRoom {
  _id: string;
  enemies: Enemy[];
  rewards: Reward[];

  constructor({ id, enemies = [], rewards = [] }: RoomConstructorProps) {
    this._id = id;
    this.enemies = enemies;
    this.rewards = rewards;
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

class TreasureRoom extends Room {
  constructor({ id, enemies, rewards }: RoomConstructorProps) {
    super({ id, enemies, rewards });
  }
}


class EventRoom extends Room {
  constructor({ id, enemies, rewards }: RoomConstructorProps) {
    super({ id, enemies, rewards });
  }
}

class RestRoom extends Room {
  constructor({ id, enemies, rewards }: RoomConstructorProps) {
    super({ id, enemies, rewards });
  }
}

class TradeRoom extends Room {
  constructor({ id, enemies, rewards }: RoomConstructorProps) {
    super({ id, enemies, rewards });
  }
}

class EnemyRoom extends Room {
  constructor({ id, enemies = [new Enemy({ name: 'enemy' })], rewards }: RoomConstructorProps) {
    super({ id });
    this.enemies = enemies;
    this.rewards = rewards;
  }
}

class MiniBossRoom extends Room {
  constructor({ id, enemies = [new Enemy({ name: 'miniboss' })], rewards }: RoomConstructorProps) {
    super({ id });
    this.enemies = enemies;
    this.rewards = rewards;
  }
}

type BossesIndexes = 0 | 1 | 2

const BOSSES: Record<BossesIndexes, Array<Enemy>> = {
  [0]: [new Enemy({ name: 'Goblin' })],
  [1]: [new Enemy({ name: 'Ork' })],
  [2]: [new Enemy({ name: 'Ogre' })]
}

class BossRoom extends Room {
  constructor({ id, level }: BossRoomConstructorProps) {
    super({ id });
    const bossesOnTheLevel = BOSSES[level as BossesIndexes];
    this.enemies = [bossesOnTheLevel[Math.floor(Math.random() * bossesOnTheLevel.length)]];
  }
}

class Player {
  name: string;
  character: PlayerCharacter | null;
  constructor({ name }: { name: string }) {
    this.name = name;
    this.character = null;
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
const nextRooms = gameSession.getNextAvailableRooms();

console.log(nextRooms);
