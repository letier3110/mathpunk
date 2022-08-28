import { RoomType } from './room.interface';

export class Room {
  constructor(randomValue: number) {
    this.name = 'Room';
    this.description = 'description';
    if (randomValue < 0.5) {
      this.type = RoomType.Fight;
    } else if (randomValue < 0.7) {
      this.type = RoomType.Event;
    } else if (randomValue < 0.8) {
      this.type = RoomType.Miniboss;
    } else if (randomValue < 0.9) {
      this.type = RoomType.Trade;
    } else if (randomValue < 0.95) {
      this.type = RoomType.Chest;
    } else {
      this.type = RoomType.Rest;
    }
  }

  name: string;
  description: string;
  type: RoomType;
}
