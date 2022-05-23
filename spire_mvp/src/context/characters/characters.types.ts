import {
  CharacterType,
  CollectibleItem,
  DisposableItem,
  PlayableCard,
} from "../types";

export interface CharacterMetadata {
  name: string;
  description: string;
  locked: boolean;
  hidden: boolean;
  maxHitpoints: number;
  hitpoints: number;
  gold: number;
  items: Array<DisposableItem>;
  relics: Array<CollectibleItem>;
  deck: Array<PlayableCard>;
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
