import React from "react";

import { CharacterCardItemInterface } from "./character-card.types";
import CharacterCard from "./character-card";

import s from "./character-card.module.css";
import { useCharacterList } from "../../context/characters/characters";
import { CharacterType, SelectableCharacter } from "../../context/types";

interface CharacterCardListProps {
  submit: (character: CharacterType) => void;
  temporarySelected: SelectableCharacter;
}

const CharacterCardList: React.FC<CharacterCardListProps> = ({
  submit,
  temporarySelected,
}) => {
  const characters = useCharacterList();
  const charactersCardItems: Array<CharacterCardItemInterface> = Object.keys(
    characters
  )
    .map((character) => {
      const characterType = character as CharacterType;
      const characterItem = characters[characterType];
      return {
        title: characterItem.name,
        description: characterItem.description,
        visible: characterItem.hidden,
        disabled: characterItem.locked,
        callback: () => submit(characterType),
        selected: characterType === temporarySelected,
      };
    })
    .filter((x) => !x.visible);
  return (
    <div className={s.container}>
      <div className={s.list}>
        {charactersCardItems.map((character, index) => (
          <CharacterCard {...character} key={index} />
        ))}
      </div>
    </div>
  );
};

export default CharacterCardList;
