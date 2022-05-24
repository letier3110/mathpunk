import React from 'react';

import ReturnButton from '../components/button/return-button';
import MenuCardList from '../components/menu-card/menu-card-list';
import { MenuCardItemInterface } from '../components/menu-card/menu-card.types';
import Mock from '../components/mock/mock';
import { NavigatorScreens } from '../components/navigator/navigator.enum';
import { emptyFn } from '../utils/empty-fn';

function Statistics() {
  const items: Array<MenuCardItemInterface> = [
    {
      title: 'Character Stats',
      description: 'The progress and statistics for each character can be seen here.',
      callback: emptyFn
    },
    {
      title: 'Leaderboards',
      description: 'View and compare your score with friends and other players.',
      callback: emptyFn
    },
    {
      title: 'Run History',
      description: 'Revisit your past attempts at conquering th Spire.',
      callback: emptyFn
    }
  ];

  return (
    <div>
      <Mock screen={NavigatorScreens.Statistics} />
      <div>
        <MenuCardList item1={items[0]} item2={items[1]} item3={items[2]} />
        <ReturnButton>Return</ReturnButton>
      </div>
    </div>
  );
}

export default Statistics;
