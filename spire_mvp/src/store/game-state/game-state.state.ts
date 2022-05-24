import {
  CharacterMetadataList,
  CharacterType,
  PlayableCharacter,
  SelectableGameMode
} from '../../interfaces/character.interface';

const CHARACTERS_METADATA: CharacterMetadataList = {
  [CharacterType.Warrior]: {
    name: 'Warrior',
    description: 'A strong, but fragile warrior.',
    // image: require("../assets/images/warrior.png"),
    locked: false,
    hidden: false,
    hitpoints: 100,
    maxHitpoints: 100,
    gold: 0,
    items: [],
    relics: [],
    deck: []
  },
  [CharacterType.Assassin]: {
    name: 'Assassin',
    description: 'A sneaky, but deadly assassin.',
    // image: require("../assets/images/warrior.png"),
    locked: true,
    hidden: false,
    hitpoints: 70,
    maxHitpoints: 70,
    gold: 50,
    items: [],
    relics: [],
    deck: []
  },
  [CharacterType.Mage]: {
    name: 'Mage',
    description: 'A powerful, but fragile mage.',
    // image: require("../assets/images/warrior.png"),
    locked: true,
    hidden: false,
    hitpoints: 50,
    maxHitpoints: 50,
    gold: 100,
    items: [],
    relics: [],
    deck: []
  },
  [CharacterType.Enigma]: {
    name: 'Enigma',
    description: 'A mysterious, but deadly enigma.',
    // image: require("../assets/images/warrior.png"),
    locked: true,
    hidden: true,
    hitpoints: 100,
    maxHitpoints: 100,
    gold: 0,
    items: [],
    relics: [],
    deck: []
  }
};

export interface GameStateState {
  gameMode: SelectableGameMode;
  character: PlayableCharacter;
  characterList: CharacterMetadataList;
}

export const gameStateInitialState: GameStateState = {
  gameMode: null,
  character: null,
  characterList: CHARACTERS_METADATA
};

export interface GameStateRootState {
  gameState: GameStateState;
}
