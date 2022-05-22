import {
  GameMode,
  PlayableCharacter,
  SelectableCharacter,
  SelectableGameMode,
} from "../types";

export interface GameStateProps {
  initialState?: GameMode;
}

export interface GameStateValue {
  gameMode: SelectableGameMode;
  character: PlayableCharacter;
  selectCharacter: (character: SelectableCharacter) => void;
  selectGameMode: (gameMode: SelectableGameMode) => void;
}
