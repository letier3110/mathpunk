import { createReducer } from '@reduxjs/toolkit';

import {
  hideCharacterAction,
  lockCharacterAction,
  restoreState,
  selectCharacterAction,
  selectGamemodeAction,
  unhideCharacterAction,
  unlockCharacterAction
} from './game-state.actions';
import { gameStateInitialState, GameStateState } from './game-state.state';

export const gameStateReducers = createReducer<GameStateState>(gameStateInitialState, builder => {
  builder.addCase(restoreState, () => ({
    ...gameStateInitialState
  }));
  builder.addCase(selectCharacterAction, (state, { payload: character }) => ({
    ...state,
    character: character ? state.characterList[character] : character
  }));
  builder.addCase(selectGamemodeAction, (state, { payload: gameMode }) => ({ ...state, gameMode }));

  builder.addCase(lockCharacterAction, (state, { payload: character }) => ({
    ...state,
    characterList: {
      ...state.characterList,
      [character]: {
        ...state.characterList[character],
        locked: true
      }
    }
  }));
  builder.addCase(unlockCharacterAction, (state, { payload: character }) => ({
    ...state,
    characterList: {
      ...state.characterList,
      [character]: {
        ...state.characterList[character],
        locked: false
      }
    }
  }));
  builder.addCase(hideCharacterAction, (state, { payload: character }) => ({
    ...state,
    characterList: {
      ...state.characterList,
      [character]: {
        ...state.characterList[character],
        hide: true
      }
    }
  }));
  builder.addCase(unhideCharacterAction, (state, { payload: character }) => ({
    ...state,
    characterList: {
      ...state.characterList,
      [character]: {
        ...state.characterList[character],
        hide: false
      }
    }
  }));
});
