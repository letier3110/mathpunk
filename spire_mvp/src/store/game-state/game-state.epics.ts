import { combineEpics } from 'redux-observable';
import { map, Observable } from 'rxjs';
import { Action } from 'ts-action';
import { ofType } from 'ts-action-operators';

// import { Slime } from '../../interfaces/enemy/slime';
import { Room } from '../../interfaces/room/room';
import { EventRoomMetadata, EventRoomType, RoomType } from '../../interfaces/room/room.interface';
import { generateMap, selectCharacterAction } from './game-state.actions';

export const startTheGameEpic = (action$: Observable<Action>) =>
  action$.pipe(
    ofType(selectCharacterAction),
    map(() => {
      const startingRoom: EventRoomMetadata = {
        name: 'Starting Location',
        description: 'Starting Location',
        type: RoomType.Event,
        eventType: EventRoomType.StartingLocation
      };

      const finalRoom: EventRoomMetadata = {
        name: 'Starting Location',
        description: 'Starting Location',
        type: RoomType.Event,
        eventType: EventRoomType.StartingLocation
      };

      // const slime = new Slime();

      const generatedRooms = [];
      for (let i = 0; i < 15; i++) {
        const randomValue = Math.random();
        const room1 = new Room(randomValue);
        const room2 = new Room(randomValue);
        const room3 = new Room(randomValue);
        const room4 = new Room(randomValue);
        const roomArray = [room1, room2, room3, room4];

        generatedRooms.push(roomArray);
      }

      const finalMap = [[startingRoom], generatedRooms.flat(1), [finalRoom]];

      return generateMap(finalMap);
    })

    // TODO: generate Game map
  );

export const gameStateEpics = combineEpics(startTheGameEpic);
