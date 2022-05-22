import React from "react";

import { useCharacter, useGameMode } from "../context/game-state/game-state";
import { GameModeType } from "../context/types";

import Mock from "../components/mock/mock";
import { NavigatorScreens } from "../components/navigator/navigator.enum";
import CharacterSelectStandard from "../components/character-select-standard/character-select-standard";

const Run: React.FC = () => {
  const gameMode = useGameMode();
  const savedCharacter = useCharacter();

  return (
    <div>
      {gameMode === GameModeType.Standard && (
        <Mock screen={NavigatorScreens.StandardRun} />
      )}
      {gameMode === GameModeType.Daily && (
        <Mock screen={NavigatorScreens.DailyRun} />
      )}
      {gameMode === GameModeType.Custom && (
        <Mock screen={NavigatorScreens.CustomRun} />
      )}
      {gameMode === GameModeType.Standard && !savedCharacter && (
        <CharacterSelectStandard />
      )}
    </div>
  );
};

export default Run;
