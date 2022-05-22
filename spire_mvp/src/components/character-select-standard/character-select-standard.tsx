import React, { useState } from "react";

import {
  useSelectCharacter,
  useSelectGameMode,
} from "../../context/game-state/game-state";

import { SelectableCharacter } from "../../context/types";
import ContinueButton from "../button/continue-button";
import ReturnButton from "../button/return-button";
import CharacterCardList from "../character-card/character-card-list";

const CharacterSelectStandard: React.FC = () => {
  const discardGameMode = useSelectGameMode();
  const [character, setCharacter] = useState<SelectableCharacter>(null);
  const selectCharacter = useSelectCharacter();

  const handleClickReturn = () => {
    discardGameMode(null);
  };

  const handleSubmit = (submitCharacter: SelectableCharacter) => {
    if (character === submitCharacter) {
      setCharacter(null);
    } else {
      setCharacter(submitCharacter);
    }
  };

  const handleClickContinue = () => {
    selectCharacter(character);
  };

  return (
    <div>
      <CharacterCardList temporarySelected={character} submit={handleSubmit} />
      <ReturnButton onClick={handleClickReturn}>Return</ReturnButton>
      {character && (
        <ContinueButton onClick={handleClickContinue}>Continue</ContinueButton>
      )}
    </div>
  );
};

export default CharacterSelectStandard;
