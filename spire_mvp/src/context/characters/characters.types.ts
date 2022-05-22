import { CharacterType } from "../types";

export interface CharacterMetadata {
  name: string;
  description: string;
  locked: boolean;
  hidden: boolean;
}

export type CharacterMetadataList = Record<CharacterType, CharacterMetadata>;

export interface CharactersProps {
  initialState?: CharacterMetadataList;
}

export interface CharactersValue {
  characterList: CharacterMetadataList;
  setCharacterList: (characterList: CharacterMetadataList) => void;
  unlockCharacter: (characterType: CharacterType) => void;
  lockCharacter: (characterType: CharacterType) => void;
  unhideCharacter: (characterType: CharacterType) => void;
  hideCharacter: (characterType: CharacterType) => void;
}
