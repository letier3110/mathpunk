import { useState } from "react";
import constate from "constate";

import {
  PlayableCharacter,
  SelectableCharacter,
  SelectableGameMode,
} from "../types";
import { GameStateProps, GameStateValue } from "./game-state.types";

export const [
  GameStateProvider,
  useGameMode,
  useCharacter,
  useSelectCharacter,
  useSelectGameMode,
] = constate(
  ({
    initialState = { gameMode: null, character: null },
  }: GameStateProps): GameStateValue => {
    const [gameMode, selectGameMode] = useState<SelectableGameMode>(
      initialState.gameMode
    );
    const [character, updateCharacter] = useState<PlayableCharacter>(
      initialState.character
    );

    const selectCharacter = (character: SelectableCharacter) => {
      updateCharacter(character);
    };

    return {
      gameMode,
      character,
      selectCharacter,
      selectGameMode,
    };
  },
  (value) => value.gameMode,
  (value) => value.character,
  (value) => value.selectCharacter,
  (value) => value.selectGameMode
);
