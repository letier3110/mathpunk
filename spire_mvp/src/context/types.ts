export enum GameModeType {
  Standard = "Standard",
  Daily = "Daily",
  Custom = "Custom",
}

export enum CharacterType {
  Warrior = "Warrior",
  Assassin = "Assassin",
  Mage = "Mage",
  Enigma = "Enigma",
}

export type SelectableGameMode = GameModeType | null;
export type SelectableCharacter = CharacterType | null;
export type PlayableCharacter = CharacterType | null;

export interface GameMode {
  gameMode: SelectableGameMode;
  character: PlayableCharacter;
}

export interface CollectibleItem {
  name: string;
}

export interface DisposableItem {
  name: string;
  count: number;
}

export interface PlayableCard {
  name: string;
}
