import { EffectType } from './effects.interface';

export enum RelicType {
  BurningBlood = 'BurningBlood'
}

export interface RelicMetadata {
  name: string;
  description: string;
  effect: EffectType;
}

export type RelicsMetadataList = Record<RelicType, RelicMetadata>;
