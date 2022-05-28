export enum EffectType {
  RegenAfterMatch = 'RegenAfterMatch',
  GainStrength = 'GainStrength',
  FirePotion = 'FirePotion',
  GainBlock = 'GainBlock',
  ReceiveDamage = 'ReceiveDamage',
  ReceiveVulnerable = 'ReceiveVulnerable'
}

export enum BaseEffectType {
  Strength = 'Strength',
  Block = 'Block',
  Damage = 'Damage',
  Vulnerable = 'Vulnerable'
}

export interface EffectMetadata {
  name: string;
  description: string;
  baseEffectType?: BaseEffectType;
}

export type EffectsMetadataList = Record<EffectType, EffectMetadata>;
