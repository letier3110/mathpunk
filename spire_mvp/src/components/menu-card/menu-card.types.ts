import { EmptyFn } from '../../utils/empty-fn';

export interface MenuCardItemInterface {
  title: string;
  description: string;
  callback: EmptyFn;
  imgSrc?: string;
  disabled?: boolean;
}
