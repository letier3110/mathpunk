// ODO SECTION
// TODO: implement GameLoop (players effect and execute enemy intensions by enemy position's order)
// TODO: implement base miniboss EnemyOrk
// TODO: implement base boss EnemyGoblinLord
// TODO: room need to generate its content depends of Game Mode / Game State / Game Session (enemies, rewards)
// ODO SECTION

// BACKLOG SECTION
// TODO: add dialogue tree to end Event Room
// TODO: add changeability of Event Room to othrer room_type (Enemy Room / Treasure Room)
// BACKLOG SECTION

// singleton
class Game {
  gameMode: GameMode | null;

  constructor() {
    this.gameMode = null;
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
    this.gameSession = null;
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
  player: Player | null;
  gameMap: GameMap | null;
  currentRoom: Room | null;
  static instance: GameSession | null = null;

  static getGameSessionInstance(): GameSession {
    if (!GameSession.instance) {
      GameSession.instance = new GameSession();
    }
    return GameSession.instance;
  }

  static setGameSessionInstance(gameSession: GameSession) {
    GameSession.instance = gameSession;
  }

  constructor() {
    this.player = null;
    this.gameMap = null;
    this.currentRoom = null;
  }

  attachPlayer(player: Player) {
    this.player = player;
  }

  getPlayer(): Player | null {
    return this.player;
  }

  attachGameMap(gameMap: GameMap) {
    this.gameMap = gameMap;
  }

  getGameMap() {
    return this.gameMap;
  }

  getNextAvailableRooms(): Room[] {
    if (!this.gameMap) return [];
    const rooms = this.gameMap.getRooms();
    if (this.currentRoom === null) return [rooms[0]];

    // TODO: change search from in array to tree with .nextRoom pointer in current rooms row
    let index = 0;
    const foundRoom = { index, value: rooms[0] };
    for (const room of rooms) {
      if (Room.isEqual(room, this.currentRoom)) {
        foundRoom.index = index;
        foundRoom.value = room;
        break;
      }
      index++;
    }
    const nextRoomIndex = foundRoom.index + 1;
    if (rooms.length <= nextRoomIndex) return [];
    return [rooms[nextRoomIndex]];
  }

  enterRoom(room: Room) {
    if (this.currentRoom && this.currentRoom.getCanLeaveRoom()) {
      this.currentRoom = room;
      if(this.currentRoom instanceof EnemyRoom && this.player) {
        const char = this.player.getCharacter()
        if(char) {
          char.getDeck().initialLoadDrawPile();
        }
        // this.currentRoom.getEnemies().forEach(enemy => {
        //   enemy.moveset.getNextMove();
        // }
        // TODO: init battle
      }
      return true;
    }
    return false;
  }

  getCurrentRoom() {
    return this.currentRoom;
  }
}

// class GameLoop {
//   game: Game;
//   constructor() {
//     const game = new Game();

//     const gameMode = new GameMode();
//     game.attachGameMode(gameMode);

//     const gameSession = new GameSession();
//     gameMode.attachGameSession(gameSession);

//     const player = new Player({ name: 'player' });
//     const map = new GameMap();
//     map.generateMap(0);

//     gameSession.attachPlayer(player);
//     gameSession.attachGameMap(map);

//     player.selectCharacter(new Warrior());
//     let nextRooms = gameSession.getNextAvailableRooms();
//     // while (nextRooms.length > 0) {
//     //   console.log(nextRooms[0]);
//     //   gameSession.enterRoom(nextRooms[0]);
//     //   nextRooms = gameSession.getNextAvailableRooms();
//     // }

//     console.log(nextRooms);

//   }
// }

class GameMap {
  rooms: Room[];
  constructor(level = 1) {
    this.rooms = [];
    this.generateMap(level);
  }

  // TODO: seed
  generateMap(level: number) {
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
      new BossRoom({ id: '11', level })
    ];
  }

  getRooms() {
    return this.rooms;
  }
}

interface Character {
  health: number;
  maxHealth: number;
  getHealth: () => number;
  getMaxHealth: () => number;
  setHealth: (health: number) => void;
  changeHealth: (health: number) => void;
  setMaxHealth: (health: number) => void;
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

  getHealth() { return this.health; }
  getMaxHealth() { return this.maxHealth; }
  setHealth(health: number) { this.health = health; }
  changeHealth(health: number) { this.health -= health; }
  setMaxHealth(maxHealth: number) { this.maxHealth = maxHealth; }
}

class PlayerCharacter extends BaseCharacter {
  deck: Deck;
  relics: Relic[];
  items: Item[];

  constructor() {
    super();
    this.deck = new EmptyDeck();
    this.relics = [];
    this.items = [];
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

    const cards: Card[] = [StrikeCard];
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

    const cards: Card[] = [StrikeCard];
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

    const cards: Card[] = [StrikeCard];
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

    const cards: Card[] = [StrikeCard];
    this.deck = new Deck(cards);
  }
}

class Relic { }

class Item { }

class Deck {
  cards: Card[];

  drawPile: Card[];
  hand: Card[];
  discardPile: Card[];

  constructor(cards: Card[]) {
    this.cards = cards;
    this.drawPile = [];
    this.hand = [];
    this.discardPile = [];
  }

  getCards() {
    return this.cards;
  }

  getDrawPile() { return this.drawPile }
  getHand() { return this.hand }
  getDiscardPile() { return this.discardPile }

  initialLoadDrawPile() { this.drawPile = shuffle(this.cards); }
  refreshDrawPile() { this.drawPile = shuffle(this.discardPile); }
  draw(n: number) { 
    const drawNumber = Math.abs(n - this.drawPile.length)
    
    this.hand.concat(this.drawPile.splice(0, drawNumber)); 
    if(n > this.drawPile.length) {
      this.refreshDrawPile();
      if(n - drawNumber > this.drawPile.length) {
        this.hand.concat(this.drawPile.splice(0, this.drawPile.length)); 
      } else {
        this.hand.concat(this.drawPile.splice(0, n - drawNumber)); 
      }
    }
  }
}

const shuffle = (array: any[]) => {
  let currentIndex = array.length, temporaryValue, randomIndex;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}

class EmptyDeck extends Deck {
  constructor() {
    super([]);
  }

  getCards() {
    return this.cards;
  }
}

interface ISelectableTarget {
  target: Enemy;
}

interface IRandomTarget {

}

interface IAreaDamage {
  target: Enemy;
}

enum CardType {
  Attack = 'Attack',
  Skill = 'Skill',
  Power = 'Power'
}

class Card {
  name: string;
  description: string;
  mana: number;
  type: string;

  constructor({ name = '', description = '', mana = 0, type = CardType.Skill }) {
    this.name = name;
    this.description = description;
    this.mana = mana;
    this.type = type;
  }

  play(targets: Enemy[]) {
    console.log(targets);
    // TODO: implement card apply effect to enemy
  }
}

enum AttackCardType {
  SingleTarget = 'SingleTarget',
  AllTargets = 'AllTargets',
  RandomTarget = 'RandomTarget',
}

class AttackCard extends Card {
  damage: number;
  subtype: string;

  constructor({ name = '', description = '', mana = 0, type = CardType.Attack, damage = 10, subtype = AttackCardType.SingleTarget }) {
    super({ name, description, mana, type });
    this.subtype = subtype;
    this.damage = damage;
  }

  play(targets: Enemy[]) {
    for (let target of targets) {
      target.changeHealth(-this.damage);
    }
  }
}

const StrikeCard = new AttackCard({ name: 'Strike', description: 'Deal 10 damage to target enemy', mana: 1, damage: 10, subtype: AttackCardType.SingleTarget });


interface EnemyContructorProps {
  name?: string;
  health?: number;
  maxHealth?: number;
  armor?: number;
}

enum IntensionType {
  Offense = 'Offense',
  Deffence = 'Deffence',
  Buff = 'Buff',
  Debuff = 'Debuff',
  OffenseBuff = 'OffenseBuff',
  DeffenceBuff = 'DeffenceBuff',
  OffenseDebuff = 'OffenseDebuff',
  DeffenceDebuff = 'DeffenceDebuff',
  DeffenceOffense = 'DeffenceOffense',
  Special = 'Special'
}

class Intension {
  type: IntensionType;
  baseDamage: number;
  count: number;
  constructor({ type = IntensionType.Offense, baseDamage = 0, count = 1 }) {
    this.type = type;
    this.baseDamage = baseDamage;
    this.count = count;
    // targets
    // effect (+hp, +maxhp, -hp, -maxhp, +armor, +status (strength))
  }
}

class Moveset {
  moves: Intension[];
  currentMove: Intension | null;
  parent: Enemy;

  constructor(parent: Enemy) {
    this.moves = [new Intension({ type: IntensionType.Offense })];
    this.parent = parent;
    this.currentMove = null;
    this.getNextMove();
    // array of moves
    // get next move
    // react to player actions
    // react to stats change
  }

  executeMove() {
    if (this.currentMove && this.currentMove.type === IntensionType.Offense) {
      const gs = GameSession.getGameSessionInstance()
      const player = gs.getPlayer();
      if(player) {
        const character = player.getCharacter();
        if(character) {
          character.changeHealth(this.currentMove.baseDamage * this.currentMove.count);
        }
      }
    }
  }

  getNextMove() {
    // Rotate array
    const move = this.moves.shift();
    if(move) {
      this.currentMove = move;
      this.moves.push(move);
    }
  }
}

class GoblinMoveset extends Moveset {

  constructor(parent: Enemy, damage: number) {
    super(parent);
    this.moves = [new Intension({ type: IntensionType.Offense, baseDamage: damage })];
    this.parent = parent;
    this.getNextMove();
  }
}

class Enemy implements Character {
  name: string;
  health: number;
  maxHealth: number;
  armor: number;
  moveset: Moveset;
  // moveset

  constructor({ name = '', health = 5, maxHealth = 5, armor = 0 }: EnemyContructorProps) {
    this.name = name;
    this.health = health;
    this.maxHealth = maxHealth;
    this.armor = armor;
    this.moveset = new Moveset(this);
    // this.moveset.getNextMove();
  }

  getName(): string {
    return this.name;
  }

  getHealth(): number {
    return this.health;
  }

  getMaxHealth(): number {
    return this.maxHealth;
  }

  setHealth(health: number) { this.health = health; }
  changeHealth(health: number) { this.health -= health; }
  setMaxHealth(maxHealth: number) { this.maxHealth = maxHealth; }

  getArmor(): number {
    return this.armor;
  }

  makeMove() {
    if (this.health > 0) {
      this.moveset.executeMove();
    }
    this.moveset.getNextMove();
  }
}

class EnemyGoblin extends Enemy {
  constructor({ name = 'goblin' }) {
    super({ name });
    this.moveset = new GoblinMoveset(this, 4);
  }
}

type Reward = Relic | Item | Card | number;

const EnemyRewardPool: Array<Reward[]> = [[new Relic()]];

const MiniBossRewardPool: Array<Reward[]> = [[new Relic()]];

const BossRewardPool: Array<Reward[]> = [[new Relic()]];

type RoomConstructorProps = {
  id: string;
  enemies?: Enemy[];
  rewards?: Reward[];
};

type BossRoomConstructorProps = {
  id: string;
  level: number;
};

interface IRoom {
  _id: string;
  enemies: Enemy[];
  rewards: Reward[];

  getCanLeaveRoom: () => boolean;
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

  getCanLeaveRoom(): boolean {
    return true;
  }

  public static isEqual(a: Room, b: Room) {
    return a._id === b._id;
  }
}

class TreasureRoom extends Room {
  isTreasureChestOpened: boolean;

  constructor({ id, enemies, rewards }: RoomConstructorProps) {
    super({ id, enemies, rewards });

    this.isTreasureChestOpened = false;
  }

  getShowTreasureChest(): boolean {
    return true;
  }

  getIsTreasureChestOpened(): boolean {
    return this.isTreasureChestOpened;
  }

  openTreasureChest(): void {
    if (this.getShowTreasureChest()) {
      this.isTreasureChestOpened = true;
    }
  }

  getCanLeaveRoom(): boolean {
    return this.getIsTreasureChestOpened();
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
  isTreasureChestOpened: boolean;

  constructor({ id, enemies = [new EnemyGoblin({})], rewards = [] }: RoomConstructorProps) {
    super({ id });
    this.enemies = enemies;
    this.rewards = rewards;
    this.isTreasureChestOpened = false;
  }

  getShowTreasureChest(): boolean {
    return this.enemies.length === 0;
  }

  getIsTreasureChestOpened(): boolean {
    return this.isTreasureChestOpened;
  }

  openTreasureChest(): void {
    if (this.getShowTreasureChest()) {
      this.isTreasureChestOpened = true;
    }
  }

  getCanLeaveRoom(): boolean {
    return this.getIsTreasureChestOpened();
  }
}

class MiniBossRoom extends Room {
  isTreasureChestOpened: boolean;

  constructor({ id, enemies = [new Enemy({ name: 'miniboss' })], rewards = [] }: RoomConstructorProps) {
    super({ id });
    this.enemies = enemies;
    this.rewards = rewards;
    this.isTreasureChestOpened = false;
  }

  getShowTreasureChest(): boolean {
    return this.enemies.length === 0;
  }

  getIsTreasureChestOpened(): boolean {
    return this.isTreasureChestOpened;
  }

  openTreasureChest(): void {
    if (this.getShowTreasureChest()) {
      this.isTreasureChestOpened = true;
    }
  }

  getCanLeaveRoom(): boolean {
    return this.getIsTreasureChestOpened();
  }
}

type BossesIndexes = 0 | 1 | 2;

const BOSSES: Record<BossesIndexes, Array<Enemy>> = {
  [0]: [new Enemy({ name: 'Goblin Lord' })],
  [1]: [new Enemy({ name: 'Ork Lord' })],
  [2]: [new Enemy({ name: 'Ogre Lord' })]
};

class BossRoom extends Room {
  isTreasureChestOpened: boolean;

  constructor({ id, level }: BossRoomConstructorProps) {
    super({ id });
    const bossesOnTheLevel = BOSSES[level as BossesIndexes];
    this.enemies = [bossesOnTheLevel[Math.floor(Math.random() * bossesOnTheLevel.length)]];
    this.isTreasureChestOpened = false;
  }

  getShowTreasureChest(): boolean {
    return this.enemies.length === 0;
  }

  getIsTreasureChestOpened(): boolean {
    return this.isTreasureChestOpened;
  }

  openTreasureChest(): void {
    if (this.getShowTreasureChest()) {
      this.isTreasureChestOpened = true;
    }
  }

  getCanLeaveRoom(): boolean {
    return this.getIsTreasureChestOpened();
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

// const GL = new GameLoop();


const game = new Game();

const gameMode = new GameMode();
game.attachGameMode(gameMode);

const gameSession = new GameSession();
gameMode.attachGameSession(gameSession);
GameSession.setGameSessionInstance(gameSession);

const player = new Player({ name: 'player' });
const map = new GameMap();
map.generateMap(0);

gameSession.attachPlayer(player);
gameSession.attachGameMap(map);

player.selectCharacter(new Warrior());
let nextRooms = gameSession.getNextAvailableRooms();
// while (nextRooms.length > 0) {
//   console.log(nextRooms[0]);
//   gameSession.enterRoom(nextRooms[0]);
//   nextRooms = gameSession.getNextAvailableRooms();
// }

console.log(nextRooms);
