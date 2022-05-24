import { createStore } from './create-store';
import { gameStateEpics } from './game-state/game-state.epics';
import { rootStateEpics } from './root-state.epics';

export const { store, persistor } = createStore(rootStateEpics, gameStateEpics);
