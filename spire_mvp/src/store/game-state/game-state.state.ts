import { CardElement, CardsMetadataList, CardSubtype, CardType } from '../../interfaces/cards.interface';
import {
  CharacterMetadataList,
  CharacterType,
  PlayableCharacter,
  SelectableGameMode
} from '../../interfaces/character.interface';
import { BaseEffectType, EffectsMetadataList, EffectType } from '../../interfaces/effects.interface';
import { ItemsMetadataList, ItemType } from '../../interfaces/items.interface';
import { RelicsMetadataList, RelicType } from '../../interfaces/relics.interface';
import { RoomMetadata } from '../../interfaces/room/room.interface';

const EFFECTS_METADATA: EffectsMetadataList = {
  [EffectType.RegenAfterMatch]: {
    name: 'Regen after match',
    description: 'Regen after match'
  },
  [EffectType.GainStrength]: {
    name: 'Gain Strength',
    description: 'Gain Strength',
    baseEffectType: BaseEffectType.Strength
  },
  [EffectType.FirePotion]: {
    name: 'Deal 20 damage to selected opponent',
    description: 'Deal 20 damage to selected opponent'
  },
  [EffectType.GainBlock]: {
    name: 'Gain Block',
    description: 'Gain Block',
    baseEffectType: BaseEffectType.Block
  },
  [EffectType.ReceiveDamage]: {
    name: 'Receive Damage',
    description: 'Receive Damage',
    baseEffectType: BaseEffectType.Damage
  },
  [EffectType.ReceiveVulnerable]: {
    name: 'Receive more damage',
    description: 'Receive more damage',
    baseEffectType: BaseEffectType.Vulnerable
  }
};

const ITEMS_METADATA: ItemsMetadataList = {
  [ItemType.FirePotion]: {
    name: 'Regen after match',
    description: 'Regen after match',
    effect: EffectType.FirePotion
  }
};

const RELICS_METADATA: RelicsMetadataList = {
  [RelicType.BurningBlood]: {
    name: 'Burning Blood',
    description: 'Regen after match',
    effect: EffectType.RegenAfterMatch
  }
};

const CARDS_METADATA: CardsMetadataList = {
  [CardType.Strike]: {
    name: 'Strike',
    cardType: CardType.Strike,
    description: 'Deal Damage to enemy',
    effect: EffectType.ReceiveDamage,
    cardElement: CardElement.Physical,
    manaCost: 1,
    cardSubtype: CardSubtype.Attack,
    upgradedVersion: CardType.StrikePlus
  },
  [CardType.Defend]: {
    name: 'Defend',
    cardType: CardType.Defend,
    description: 'Shield you',
    effect: EffectType.ReceiveDamage,
    cardElement: CardElement.Physical,
    manaCost: 1,
    cardSubtype: CardSubtype.Skill,
    upgradedVersion: CardType.DefendPlus
  },
  [CardType.Bash]: {
    name: 'Bash',
    cardType: CardType.Bash,
    description: 'Bashes enemy',
    effect: EffectType.ReceiveDamage,
    cardElement: CardElement.Physical,
    manaCost: 2,
    cardSubtype: CardSubtype.Attack,
    upgradedVersion: CardType.Bash
  },
  [CardType.StrikePlus]: {
    name: 'Strike+',
    cardType: CardType.StrikePlus,
    description: 'Deal Damage to enemy',
    effect: EffectType.ReceiveDamage,
    cardElement: CardElement.Physical,
    manaCost: 1,
    upgraded: true,
    cardSubtype: CardSubtype.Attack,
    upgradedVersion: null
  },
  [CardType.DefendPlus]: {
    name: 'Defend+',
    cardType: CardType.DefendPlus,
    description: 'Shield you',
    effect: EffectType.ReceiveDamage,
    cardElement: CardElement.Physical,
    manaCost: 1,
    upgraded: true,
    cardSubtype: CardSubtype.Skill,
    upgradedVersion: null
  },
  [CardType.BashPlus]: {
    name: 'Bash+',
    cardType: CardType.BashPlus,
    description: 'Bashes enemy',
    effect: EffectType.ReceiveDamage,
    cardElement: CardElement.Physical,
    manaCost: 2,
    cardSubtype: CardSubtype.Attack,
    upgraded: true,
    upgradedVersion: null
  }
};

const CHARACTERS_METADATA: CharacterMetadataList = {
  [CharacterType.Warrior]: {
    name: 'Warrior',
    description: 'A strong, but fragile warrior.',
    // image: require("../assets/images/warrior.png"),
    charactedType: CharacterType.Warrior,
    locked: false,
    hidden: false,
    hitpoints: 100,
    maxHitpoints: 100,
    gold: 0,
    mana: 3,
    maxMana: 3,
    items: [],
    relics: [RELICS_METADATA[RelicType.BurningBlood]],
    deck: [
      CARDS_METADATA.Strike,
      CARDS_METADATA.Strike,
      CARDS_METADATA.Strike,
      CARDS_METADATA.Strike,
      CARDS_METADATA.Strike,
      CARDS_METADATA.Defend,
      CARDS_METADATA.Defend,
      CARDS_METADATA.Defend,
      CARDS_METADATA.Defend,
      CARDS_METADATA.Bash
    ]
  },
  [CharacterType.Assassin]: {
    name: 'Assassin',
    description: 'A sneaky, but deadly assassin.',
    // image: require("../assets/images/warrior.png"),
    charactedType: CharacterType.Assassin,
    locked: true,
    hidden: false,
    hitpoints: 70,
    maxHitpoints: 70,
    gold: 50,
    mana: 3,
    maxMana: 3,
    items: [],
    relics: [],
    deck: []
  },
  [CharacterType.Mage]: {
    name: 'Mage',
    description: 'A powerful, but fragile mage.',
    // image: require("../assets/images/warrior.png"),
    charactedType: CharacterType.Mage,
    locked: true,
    hidden: false,
    hitpoints: 50,
    maxHitpoints: 50,
    gold: 100,
    mana: 3,
    maxMana: 3,
    items: [],
    relics: [],
    deck: []
  },
  [CharacterType.Enigma]: {
    name: 'Enigma',
    description: 'A mysterious, but deadly enigma.',
    // image: require("../assets/images/warrior.png"),
    charactedType: CharacterType.Enigma,
    locked: true,
    hidden: true,
    hitpoints: 100,
    maxHitpoints: 100,
    gold: 0,
    mana: 3,
    maxMana: 3,
    items: [],
    relics: [],
    deck: []
  }
};

export interface GameStateState {
  gameMode: SelectableGameMode;
  character: PlayableCharacter;
  characterList: CharacterMetadataList;
  effectsList: EffectsMetadataList;
  relicsList: RelicsMetadataList;
  itemsList: ItemsMetadataList;
  cardsList: CardsMetadataList;
  currentRoom: number;
  currentLevel: number;
  gameMap: Array<Array<RoomMetadata>>;
}

export const gameStateInitialState: GameStateState = {
  gameMode: null,
  character: null,
  characterList: CHARACTERS_METADATA,
  effectsList: EFFECTS_METADATA,
  relicsList: RELICS_METADATA,
  itemsList: ITEMS_METADATA,
  cardsList: CARDS_METADATA,
  currentRoom: 0,
  currentLevel: 0,
  gameMap: []
};

export interface GameStateRootState {
  gameState: GameStateState;
}
