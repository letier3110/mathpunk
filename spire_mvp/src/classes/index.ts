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

}

class Warrior implements Character {

}

class Mage implements Character {

}

class Rogue implements Character {

}

class Enigma implements Character {

}

class Relic {

}

class Item {

}

class Deck {

}

class Card {

}

type Reward = Relic | Item | Card | number;

type RoomConstructorProps = {
  name: string;
}

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
  constructor({name}: {name:string}) {
    this.name = name;  
  }

  public getName(): string {
    return this.name;
  }

}

class Enemy {
  name: string;
  constructor({name}: {name:string}) {
    this.name = name;  
  }

  public getName(): string {
    return this.name;
  }
}

const enemy = new Enemy({name: 'goblin'});
const player = new Player({name: 'player'});
const room = new Room({name: 'room'});

console.log('room')