import React from 'react';

import CharacterSelectStandard from '../components/character-select-standard/character-select-standard';
import Mock from '../components/mock/mock';
import { NavigatorScreens } from '../components/navigator/navigator.enum';
import { GameModeType } from '../interfaces/character.interface';
import { useCharacter, useGameMode } from '../store/game-state/game-state.selectors';

const Run: React.FC = () => {
  const gameMode = useGameMode();
  const savedCharacter = useCharacter();

  return (
    <div>
      {gameMode === GameModeType.Standard && <Mock screen={NavigatorScreens.StandardRun} />}
      {gameMode === GameModeType.Daily && <Mock screen={NavigatorScreens.DailyRun} />}
      {gameMode === GameModeType.Custom && <Mock screen={NavigatorScreens.CustomRun} />}
      {gameMode === GameModeType.Standard && !savedCharacter && <CharacterSelectStandard />}
    </div>
  );
};

export default Run;
