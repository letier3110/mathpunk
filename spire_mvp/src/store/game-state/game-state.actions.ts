import { createAction } from '@reduxjs/toolkit';

import { CharacterType, SelectableCharacter, SelectableGameMode } from '../../interfaces/character.interface';

export const selectCharacterAction = createAction<SelectableCharacter>('gamestate/SELECT_CHARACTER');

export const selectGamemodeAction = createAction<SelectableGameMode>('gamestate/SELECT_GAMEMODE');

export const lockCharacterAction = createAction<CharacterType>('gamestate/LOCK_CHARACTER');
export const unlockCharacterAction = createAction<CharacterType>('gamestate/UNLOCK_CHARACTER');
export const hideCharacterAction = createAction<CharacterType>('gamestate/HIDE_CHARACTER');
export const unhideCharacterAction = createAction<CharacterType>('gamestate/UNHIDE_CHARACTER');

export const restoreState = createAction<void>('gamestate/DEBUG_RESTORE_STATE');
