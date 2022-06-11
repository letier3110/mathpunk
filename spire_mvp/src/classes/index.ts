// import Enemy from "./enemy";

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
  player: Player | null;
  enemies: Enemy[];
  rewards: Reward[];
}

class Room implements IRoom {
  name: string;
  player: Player | null;
  enemies: Enemy[];
  rewards: Reward[];

  constructor({ name }: RoomConstructorProps) {
    this.name = name;
    this.player = null;
    this.enemies = [];
    this.rewards = [];
  }

  public attachPlayer({ player }: { player: Player }): void {
    this.player = player;
  }

  public attachEnemies({ enemies }: { enemies: Enemy[] }): void {
    this.enemies = enemies;
  }

  public attachRewards({ rewards }: { rewards: Reward[] }): void {
    this.rewards = rewards;
  }

  public getPlayer(): Player | null {
    return this.player;
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