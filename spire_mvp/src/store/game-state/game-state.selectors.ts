import { useSelector } from 'react-redux';

import { CharacterMetadataList, PlayableCharacter, SelectableGameMode } from '../../interfaces/character.interface';
import { GameStateRootState } from './game-state.state';

export const useCharacter = () =>
  useSelector<GameStateRootState, PlayableCharacter>(({ gameState }) => gameState.character);

export const useGameMode = () =>
  useSelector<GameStateRootState, SelectableGameMode>(({ gameState }) => gameState.gameMode);

export const useCharacterList = () =>
  useSelector<GameStateRootState, CharacterMetadataList>(({ gameState }) => gameState.characterList);
