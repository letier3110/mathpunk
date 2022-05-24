import React from 'react';

import { emptyFn } from '../../utils/empty-fn';
import s from './menu-card.module.css';
import { MenuCardItemInterface } from './menu-card.types';

const MenuCard: React.FC<MenuCardItemInterface> = ({
  title,
  description,
  callback = emptyFn,
  imgSrc,
  disabled = false
}) => {
  const handleClick = () => {
    if (disabled) return void 0;
    callback();
  };

  return (
    <div className={[s.item, disabled && s.itemDisabled].join(' ')} onClick={handleClick}>
      <div className={s.title}>{title}</div>
      <div className={s.img}>{imgSrc !== undefined ? <img src={imgSrc} alt={imgSrc} /> : ''}</div>
      <div className={s.description}>{description}</div>
    </div>
  );
};

export default MenuCard;
