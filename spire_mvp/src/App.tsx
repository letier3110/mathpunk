import React from "react";

import { GameStateProvider } from "./context/game-state/game-state";
import { CharactersProvider } from "./context/characters/characters";

import Navigator from "./components/navigator/navigator";

import "./App.css";
import { GameMode, GameModeType } from "./context/types";

const mockGameState: GameMode = {
  gameMode: GameModeType.Standard,
  character: null,
};

function App() {
  return (
    <GameStateProvider initialState={mockGameState}>
      <CharactersProvider>
        <div className="App">
          <Navigator />
        </div>
      </CharactersProvider>
    </GameStateProvider>
  );
}

export default App;
