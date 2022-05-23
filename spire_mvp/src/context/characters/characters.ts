import { useState } from "react";
import constate from "constate";

import { CharacterType } from "../types";
import {
  CharacterMetadataList,
  CharactersProps,
  CharactersValue,
} from "./characters.types";

// metadata + actual state

const CHARACTERS_METADATA: CharacterMetadataList = {
  [CharacterType.Warrior]: {
    name: "Warrior",
    description: "A strong, but fragile warrior.",
    // image: require("../assets/images/warrior.png"),
    locked: false,
    hidden: false,
    hitpoints: 100,
    maxHitpoints: 100,
    gold: 0,
    items: [],
    relics: [],
    deck: [],
  },
  [CharacterType.Assassin]: {
    name: "Assassin",
    description: "A sneaky, but deadly assassin.",
    // image: require("../assets/images/warrior.png"),
    locked: true,
    hidden: false,
    hitpoints: 70,
    maxHitpoints: 70,
    gold: 50,
    items: [],
    relics: [],
    deck: [],
  },
  [CharacterType.Mage]: {
    name: "Mage",
    description: "A powerful, but fragile mage.",
    // image: require("../assets/images/warrior.png"),
    locked: true,
    hidden: false,
    hitpoints: 50,
    maxHitpoints: 50,
    gold: 100,
    items: [],
    relics: [],
    deck: [],
  },
  [CharacterType.Enigma]: {
    name: "Enigma",
    description: "A mysterious, but deadly enigma.",
    // image: require("../assets/images/warrior.png"),
    locked: true,
    hidden: true,
    hitpoints: 100,
    maxHitpoints: 100,
    gold: 0,
    items: [],
    relics: [],
    deck: [],
  },
};

export const [
  CharactersProvider,
  useCharacterList,
  useSetCharacterList,
  useLockCharacter,
  useHideCharacter,
  useUnlockCharacter,
  useUnhideCharacter,
] = constate(
  ({
    initialState = CHARACTERS_METADATA,
  }: CharactersProps): CharactersValue => {
    const [characterList, setCharacterList] =
      useState<CharacterMetadataList>(initialState);

    const unlockCharacter = (characterType: CharacterType) => {
      const newCharacterList = {
        ...characterList,
        [characterType]: {
          ...characterList[characterType],
          locked: false,
        },
      };
      setCharacterList(newCharacterList);
    };

    const lockCharacter = (characterType: CharacterType) => {
      const newCharacterList = {
        ...characterList,
        [characterType]: {
          ...characterList[characterType],
          locked: true,
        },
      };
      setCharacterList(newCharacterList);
    };

    const unhideCharacter = (characterType: CharacterType) => {
      const newCharacterList = {
        ...characterList,
        [characterType]: {
          ...characterList[characterType],
          hidden: false,
        },
      };
      setCharacterList(newCharacterList);
    };

    const hideCharacter = (characterType: CharacterType) => {
      const newCharacterList = {
        ...characterList,
        [characterType]: {
          ...characterList[characterType],
          hidden: true,
        },
      };
      setCharacterList(newCharacterList);
    };

    return {
      characterList,
      setCharacterList,
      lockCharacter,
      hideCharacter,
      unlockCharacter,
      unhideCharacter,
    };
  },
  (value) => value.characterList,
  (value) => value.setCharacterList,
  (value) => value.lockCharacter,
  (value) => value.hideCharacter,
  (value) => value.unlockCharacter,
  (value) => value.unhideCharacter
);
