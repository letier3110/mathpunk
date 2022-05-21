import React from "react";
import { useNavigate } from "react-router-dom";
import ReturnButton from "../components/button/return-button";
import MenuCardList from "../components/menu-card/menu-card-list";
import { MenuCardItemInterface } from "../components/menu-card/menu-card.types";
import Mock from "../components/mock/mock";
import { NavigatorScreens } from "../components/navigator/navigator.enum";
import { NavigatorScreensMap } from "../components/navigator/navigator.map";
import { emptyFn } from "../utils/empty-fn";

function GameModeSelect() {
  const navigate = useNavigate();

  const items: Array<MenuCardItemInterface> = [
    {
      title: "Standard",
      description: "Embark on a quest to conquer the spire!",
      callback: () =>
        navigate(NavigatorScreensMap[NavigatorScreens.StandardRun]),
    },
    {
      title: "Daily Run",
      description:
        "A new challenge is available once a day.\n\nCompete with other players to conquer the spire!",
      callback: emptyFn,
    },
    {
      title: "Custom",
      description: "Play a Daily Run to unlock this gamemode.",
      callback: emptyFn,
      disabled: true,
    },
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
