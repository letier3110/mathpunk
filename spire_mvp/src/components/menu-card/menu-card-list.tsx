import React from 'react';

import MenuCard from './menu-card';
import s from './menu-card.module.css';
import { MenuCardItemInterface } from './menu-card.types';

interface MenuCardListProps {
  item1: MenuCardItemInterface;
  item2: MenuCardItemInterface;
  item3: MenuCardItemInterface;
}

const MenuCardList: React.FC<MenuCardListProps> = ({ item1, item2, item3 }) => {
  return (
    <div className={s.container}>
      <div className={s.list}>
        <MenuCard {...item1} />
        <MenuCard {...item2} />
        <MenuCard {...item3} />
      </div>
    </div>
  );
};

export default MenuCardList;
