import { EmptyFn } from '../../utils/empty-fn';

export interface CharacterCardItemInterface {
  title: string;
  description: string;
  callback: EmptyFn;
  imgSrc?: string;
  disabled?: boolean;
}
