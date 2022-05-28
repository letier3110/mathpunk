import { EffectType } from './effects.interface';

export enum ItemType {
  FirePotion = 'FirePotion'
}

export interface ItemMetadata {
  name: string;
  description: string;
  effect: EffectType;
}

export type ItemsMetadataList = Record<ItemType, ItemMetadata>;
