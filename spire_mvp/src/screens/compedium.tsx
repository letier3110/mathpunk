import React from 'react';

import ReturnButton from '../components/button/return-button';
import MenuCardList from '../components/menu-card/menu-card-list';
import { MenuCardItemInterface } from '../components/menu-card/menu-card.types';
import Mock from '../components/mock/mock';
import { NavigatorScreens } from '../components/navigator/navigator.enum';
import { emptyFn } from '../utils/empty-fn';

const items: Array<MenuCardItemInterface> = [
  {
    title: 'Card Library',
    description: 'View all of the cards you have encountered in the game.',
    callback: emptyFn
  },
  {
    title: 'Relic Collection',
    description: 'Examin the various trinkets and artifacts obtained in the game.',
    callback: emptyFn
  },
  {
    title: 'Potion Lab',
    description: 'Observe the numerous potions found while exploring the Spire.',
    callback: emptyFn
  }
];

function Compedium() {
  return (
    <div>
      <Mock screen={NavigatorScreens.Compedium} />
      <div>
        <MenuCardList item1={items[0]} item2={items[1]} item3={items[2]} />
        <ReturnButton>Return</ReturnButton>
      </div>
    </div>
  );
}

export default Compedium;
