export enum RoomType {
  Fight = 'Fight',
  Miniboss = 'Miniboss',
  Boss = 'Boss',
  Event = 'Event',
  Rest = 'Rest',
  Chest = 'Chest',
  Trade = 'Trade'
}

export enum EventRoomType {
  Fight = 'Fight',
  Miniboss = 'Miniboss',
  TorchChallenge = 'TorchChallenge',
  StartingLocation = 'StartingLocation',
  Trade = 'Trade'
}

export interface RoomMetadata {
  name: string;
  description: string;
  type: RoomType;
}

export interface EventRoomMetadata extends RoomMetadata {
  eventType: EventRoomType;
}

export type RoomsMetadataList = Record<RoomType, RoomMetadata>;
