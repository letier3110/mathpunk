import { EffectType } from './effects.interface';

export enum CardType {
  Strike = 'Strike',
  StrikePlus = 'StrikePlus',
  Defend = 'Defend',
  DefendPlus = 'DefendPlus',
  Bash = 'Bash',
  BashPlus = 'BashPlus'
}

export enum CardElement {
  Magic = 'Magic',
  Nature = 'Nature',
  Physical = 'Physical',
  Mystic = 'Mystic',
  Neutral = 'Neutral'
}

export enum CardSubtype {
  Attack = 'Attack',
  Skill = 'Skill',
  Power = 'Power'
}

export interface CardMetadata {
  name: string;
  description: string;
  effect: EffectType;
  cardElement: CardElement;
  cardType: CardType;
  upgradedVersion: CardType | null;
  cardSubtype: CardSubtype;
  upgraded?: boolean;
  manaCost?: number;
}

export type CardsMetadataList = Record<CardType, CardMetadata>;
