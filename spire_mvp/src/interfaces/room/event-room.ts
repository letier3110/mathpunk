import { Room } from './room';
import { EventRoomType } from './room.interface';

export class EventRoom extends Room {
  constructor(randomValue: number) {
    super(randomValue);
    if (randomValue < 0.5) {
      this.eventType = EventRoomType.Fight;
    } else if (randomValue < 0.7) {
      this.eventType = EventRoomType.TorchChallenge;
    } else if (randomValue < 0.8) {
      this.eventType = EventRoomType.Miniboss;
    } else {
      this.eventType = EventRoomType.Trade;
    }
  }

  eventType: EventRoomType;
}
