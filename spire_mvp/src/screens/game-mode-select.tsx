import React from 'react';
import { useDispatch } from 'react-redux';
import { useNavigate } from 'react-router-dom';

import ReturnButton from '../components/button/return-button';
import MenuCardList from '../components/menu-card/menu-card-list';
import { MenuCardItemInterface } from '../components/menu-card/menu-card.types';
import Mock from '../components/mock/mock';
import { NavigatorScreens } from '../components/navigator/navigator.enum';
import { NavigatorScreensMap } from '../components/navigator/navigator.map';
import { GameModeType } from '../interfaces/character.interface';
import { selectGamemodeAction } from '../store/game-state/game-state.actions';

function GameModeSelect() {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  // const gameModeSelect = useSelectGameMode();

  const items: Array<MenuCardItemInterface> = [
    {
      title: 'Standard',
      description: 'Embark on a quest to conquer the spire!',
      callback: () => {
        dispatch(selectGamemodeAction(GameModeType.Standard));
        navigate(NavigatorScreensMap[NavigatorScreens.Run]);

        return void 0;
      }
    },
    {
      title: 'Daily Run',
      description: 'Play a Standard Run to unlock this gamemode.',
      // description:
      //   "A new challenge is available once a day.\n\nCompete with other players to conquer the spire!",
      callback: () => {
        dispatch(selectGamemodeAction(GameModeType.Daily));
        navigate(NavigatorScreensMap[NavigatorScreens.Run]);

        return void 0;
      },
      disabled: true
    },
    {
      title: 'Custom',
      description: 'Play a Daily Run to unlock this gamemode.',
      callback: () => {
        dispatch(selectGamemodeAction(GameModeType.Custom));
        navigate(NavigatorScreensMap[NavigatorScreens.Run]);

        return void 0;
      },
      disabled: true
    }
  ];

  return (
    <div>
      <Mock screen={NavigatorScreens.GameModeSelect} />
      <div>
        <MenuCardList item1={items[0]} item2={items[1]} item3={items[2]} />
        <ReturnButton>Return</ReturnButton>
      </div>
    </div>
  );
}

export default GameModeSelect;
